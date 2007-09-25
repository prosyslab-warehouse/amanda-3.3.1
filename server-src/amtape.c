/*
 * Amanda, The Advanced Maryland Automatic Network Disk Archiver
 * Copyright (c) 1991-1998 University of Maryland at College Park
 * All Rights Reserved.
 *
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of U.M. not be used in advertising or
 * publicity pertaining to distribution of the software without specific,
 * written prior permission.  U.M. makes no representations about the
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 * U.M. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL U.M.
 * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * Authors: the Amanda Development Team.  Its members are listed in a
 * file named AUTHORS, in the root directory of this distribution.
 */
/*
 * $Id: amtape.c,v 1.47 2006/07/25 18:27:57 martinea Exp $
 *
 * tape changer interface program
 */
#include "amanda.h"
#include "conffile.h"
#include "tapefile.h"
#include "taperscan.h"
#include "clock.h"
#include "changer.h"
#include "version.h"
#include "device.h"
#include "timestamp.h"

/* local functions */
static void usage(void);
int main(int argc, char **argv);
static void reset_changer(int argc, char **argv);
static void eject_tape(int argc, char **argv);
static void clean_tape(int argc, char **argv);
static void load_slot(int argc, char **argv);
static void load_label(int argc, char **argv);
static void show_slots(int argc, char **argv);
static void show_current(int argc, char **argv);
static void amtape_taper_scan(int argc, char **argv);
static void show_device(int argc, char **argv);
static int loadlabel_slot(void *ud, int rc, char *slotstr, char *device);
int show_init(void *ud, int rc, int ns, int bk, int s);
static int show_slots_slot(void *ud, int rc, char *slotstr, char *device);

static const struct {
    const char *name;
    void (*fn)(int, char **);
    const char *usage;
} cmdtab[] = {
    { "reset", reset_changer,
	T_("reset                Reset changer to known state") },
    { "eject", eject_tape,
	T_("eject                Eject current tape from drive") },
    { "clean", clean_tape,
	T_("clean                Clean the drive") },
    { "show", show_slots,
	T_("show                 Show contents of all slots") },
    { "current", show_current,
	T_("current              Show contents of current slot") },
    { "slot" , load_slot,
	T_("slot <slot #>        load tape from slot <slot #>") },
    { "slot" , load_slot,
	T_("slot current         load tape from current slot") },
    { "slot" , load_slot,
	T_("slot prev            load tape from previous slot") },
    { "slot" , load_slot,
	T_("slot next            load tape from next slot") },
    { "slot" , load_slot,
	T_("slot advance         advance to next slot but do not load") },
    { "slot" , load_slot,
	T_("slot first           load tape from first slot") },
    { "slot" , load_slot,
	T_("slot last            load tape from last slot") },
    { "label", load_label,
	T_("label <label>        find and load labeled tape") },
    { "taper", amtape_taper_scan,
	T_("taper                perform taper's scan alg.") },
    { "device", show_device,
	T_("device               show current tape device") },
    { "update", show_slots,
	T_("update               update the label matchingdatabase")},
};
#define	NCMDS	(int)(sizeof(cmdtab) / sizeof(cmdtab[0]))

static void
usage(void)
{
    int i;

    fprintf(stderr, _("Usage: amtape%s <conf> <command> {<args>} [-o configoption]*\n"), versionsuffix());
    fprintf(stderr, _("\tValid commands are:\n"));
    for (i = 0; i < NCMDS; i++)
	fprintf(stderr, "\t\t%s\n", _(cmdtab[i].usage));
    exit(1);
}

int
main(
    int		argc,
    char **	argv)
{
    char *conffile;
    char *conf_tapelist;
    char *argv0 = argv[0];
    unsigned long malloc_hist_1, malloc_size_1;
    unsigned long malloc_hist_2, malloc_size_2;
    int i;
    int have_changer;
    int new_argc;
    char **new_argv;

    /*
     * Configure program for internationalization:
     *   1) Only set the message locale for now.
     *   2) Set textdomain for all amanda related programs to "amanda"
     *      We don't want to be forced to support dozens of message catalogs.
     */  
    setlocale(LC_MESSAGES, "C");
    textdomain("amanda"); 

    safe_fd(-1, 0);
    safe_cd();

    set_pname("amtape");

    /* Don't die when child closes pipe */
    signal(SIGPIPE, SIG_IGN);

    dbopen(DBG_SUBDIR_SERVER);

    malloc_size_1 = malloc_inuse(&malloc_hist_1);

    erroutput_type = ERR_INTERACTIVE;

    parse_conf(argc, argv, &new_argc, &new_argv);
    if(new_argc < 3) usage();

    config_name = new_argv[1];

    config_dir = vstralloc(CONFIG_DIR, "/", config_name, "/", NULL);
    conffile = stralloc2(config_dir, CONFFILE_NAME);
    if (read_conffile(conffile)) {
	error(_("errors processing config file \"%s\""), conffile);
	/*NOTREACHED*/
    }

    check_running_as(RUNNING_AS_DUMPUSER | RUNNING_WITHOUT_SETUID);

    dbrename(config_name, DBG_SUBDIR_SERVER);

    conf_tapelist = getconf_str(CNF_TAPELIST);
    if (*conf_tapelist == '/') {
	conf_tapelist = stralloc(conf_tapelist);
    } else {
	conf_tapelist = stralloc2(config_dir, conf_tapelist);
    }
    if (read_tapelist(conf_tapelist)) {
	error(_("could not load tapelist \"%s\""), conf_tapelist);
	/*NOTREACHED*/
    }
    amfree(conf_tapelist);

    if((have_changer = changer_init()) == 0) {
	error(_("no tpchanger specified in \"%s\""), conffile);
	/*NOTREACHED*/
    } else if (have_changer != 1) {
	error(_("changer initialization failed: %s"), strerror(errno));
	/*NOTREACHED*/
    }

    /* switch on command name */

    new_argc -= 2; new_argv += 2;
    for (i = 0; i < NCMDS; i++)
	if (strcmp(new_argv[0], cmdtab[i].name) == 0) {
	    (*cmdtab[i].fn)(new_argc, new_argv);
	    break;
	}
    if (i == NCMDS) {
	fprintf(stderr, _("%s: unknown command \"%s\"\n"), argv0, new_argv[0]);
	usage();
    }

    amfree(changer_resultstr);
    amfree(conffile);
    amfree(config_dir);

    malloc_size_2 = malloc_inuse(&malloc_hist_2);

    if(malloc_size_1 != malloc_size_2) {
	malloc_list(fileno(stderr), malloc_hist_1, malloc_hist_2);
    }

    dbclose();
    return 0;
}

/* ---------------------------- */

static void
reset_changer(G_GNUC_UNUSED int	argc,
              G_GNUC_UNUSED char ** argv) {
    char *slotstr = NULL;

    switch(changer_reset(&slotstr)) {
    case 0:
	fprintf(stderr, _("%s: changer is reset, slot %s is loaded.\n"),
		get_pname(), slotstr);
	break;
    case 1:
	fprintf(stderr, _("%s: changer is reset, but slot %s not loaded: %s\n"),
		get_pname(), slotstr, changer_resultstr);
	break;
    default:
	error(_("could not reset changer: %s"), changer_resultstr);
	/*NOTREACHED*/
    }
    amfree(slotstr);
}


/* ---------------------------- */
static void
clean_tape(G_GNUC_UNUSED int	argc,
           G_GNUC_UNUSED char ** argv) {
    char *devstr = NULL;

    if(changer_clean(&devstr) == 0) {
	fprintf(stderr, _("%s: device %s is clean.\n"), get_pname(), devstr);
    } else {
	fprintf(stderr, _("%s: device %s not clean: %s\n"),
		get_pname(), devstr ? devstr : "??", changer_resultstr);
    }
    amfree(devstr);
}


/* ---------------------------- */
static void
eject_tape(G_GNUC_UNUSED int	argc,
           G_GNUC_UNUSED char ** argv) {
    char *slotstr = NULL;

    if(changer_eject(&slotstr) == 0) {
	fprintf(stderr, _("%s: slot %3s is ejected.\n"), get_pname(), slotstr);
    } else {
	fprintf(stderr, _("%s: slot %3s not ejected: %s\n"),
		get_pname(), slotstr ? slotstr : "??", changer_resultstr);
    }
    amfree(slotstr);
}


/* ---------------------------- */

static void
load_slot(
    int		argc,
    char **	argv)
{
    char *slotstr = NULL, *devicename = NULL;
    int is_advance;
    Device * device;

    if(argc != 2)
	usage();

    device_api_init();

    is_advance = (strcmp(argv[1], "advance") == 0);
    if(changer_loadslot(argv[1], &slotstr, &devicename)) {
	error(_("could not load slot %s: %s"), slotstr, changer_resultstr);
	/*NOTREACHED*/
    }
    
    if (!is_advance) {
        device = device_open(devicename);
        if (device == NULL) {
            fprintf(stderr,
                    _("%s: could not open device %s"), get_pname(),
                    devicename);
        } else {
            g_object_unref(device);
        }
    }

    fprintf(stderr, _("%s: changed to slot %s"), get_pname(), slotstr);
    if(! is_advance) {
	fprintf(stderr, _(" on %s"), devicename);
    }
    fputc('\n', stderr);
    amfree(slotstr);
    amfree(devicename);
}


/* ---------------------------- */

/* This initalizes the ChangerStatus structure for all commands that
   use changer_find; namely, show_slots, load_label, and
   show_current. */
static int 
scan_init(G_GNUC_UNUSED void * data, int rc, G_GNUC_UNUSED int numslots,
          G_GNUC_UNUSED int backwards, G_GNUC_UNUSED int searchable) {
    if(rc != 0) {
	error(_("could not get changer info: %s"), changer_resultstr);
	/*NOTREACHED*/
    }

    return 0;
}

static int scan_init_print(void * data, int rc, int numslots,
                         int backwards, int searchable) {
    
    fprintf(stderr, _("%s: scanning all %d slots in tape-changer rack:\n"),
            get_pname(), numslots);

    return scan_init(data, rc, numslots, backwards, searchable);
}

typedef struct {
    gboolean found;
    char *searchlabel;
} LabelChangerStatus;

/* This is the 'user_slot' callback for the 'load label' command. */
static int
loadlabel_slot(
    void *	ud,
    int		rc,
    char *	slotstr,
    char *	device_name)
{
    LabelChangerStatus * status = ud;
    Device * device;

    if (rc > 1) {
	error(_("could not load slot %s: %s"), slotstr, changer_resultstr);
        g_assert_not_reached();
    } else if (rc == 1) {
	fprintf(stderr, _("%s: slot %3s: %s\n"),
		get_pname(), slotstr, changer_resultstr);
        return 0;
    }

    device = device_open(device_name);
    if (device == NULL) {
        fprintf(stderr, _("%s: slot %3s: Could not open device.\n"),
                get_pname(), slotstr);
        return 0;
    }
    
    device_set_startup_properties_from_config(device);

    if (device->volume_label == NULL) {
        fprintf(stderr, _("%s: slot %3s: Not an Amanda tape.\n"),
                get_pname(), slotstr);
        g_object_unref(device);
        return 0;
    }
    
    fprintf(stderr, _("%s: slot %3s: time %-14s label %s"),
            get_pname(), slotstr, device->volume_time, device->volume_label);

    if(strcmp(device->volume_label, status->searchlabel) != 0) {
        fprintf(stderr, _(" (wrong tape)\n"));
        g_object_unref(device);
        return 0;
    } else {
        fprintf(stderr, _(" (exact label match)\n"));
        g_object_unref(device);
        status->found = 1;
        return 1;
    }

    g_assert_not_reached();
}

/* This does the 'load label' command. */
static void
load_label(
    int		argc,
    char **	argv)
{
    LabelChangerStatus status;

    if(argc != 2)
	usage();
    
    device_api_init();

    status.searchlabel = argv[1];

    fprintf(stderr, _("%s: scanning for tape with label %s\n"),
	    get_pname(), status.searchlabel);

    status.found = 0;

    changer_find(&status, scan_init, loadlabel_slot, status.searchlabel);

    if(status.found)
	fprintf(stderr, _("%s: label %s is now loaded.\n"),
		get_pname(), status.searchlabel);
    else
	fprintf(stderr, _("%s: could not find label %s in tape rack.\n"),
		get_pname(), status.searchlabel);
}


/* ---------------------------- */

/* This is the user_slot function for "amtape show". */
static int
show_slots_slot(G_GNUC_UNUSED void * data, int rc, char * slotstr,
                char * device_name)
{
    Device * device;

    if(rc > 1) {
	error(_("could not load slot %s: %s"), slotstr, changer_resultstr);
        g_assert_not_reached();
    }

    if(rc == 1) {
	fprintf(stderr, _("slot %s: %s\n"), slotstr, changer_resultstr);
        return 0;
    }

    device = device_open(device_name);
    if (device == NULL) {
        fprintf(stderr, _("%s: slot %3s: Could not open device.\n"),
                get_pname(), slotstr);
    } else {
        device_set_startup_properties_from_config(device);
        if (device->volume_label == NULL) {
            fprintf(stderr, _("%s: slot %3s: Not an Amanda tape.\n"),
                    get_pname(), slotstr);
        } else {
            fprintf(stderr, _("slot %3s: time %-14s label %s\n"),
                    slotstr, device->volume_time, device->volume_label);
        }
    }

    if (device != NULL)
        g_object_unref(device);

    return 0;
}

static void
show_current(int argc, G_GNUC_UNUSED char ** argv) {
    if(argc != 1)
	usage();

    device_api_init();

    fprintf(stderr, _("%s: scanning current slot in tape-changer rack:\n"),
	    get_pname());
    changer_current(NULL, scan_init, show_slots_slot);
}

static void
show_slots(int argc, G_GNUC_UNUSED char ** argv) {
    if(argc != 1)
	usage();

    device_api_init();
    changer_find(NULL, scan_init_print, show_slots_slot, NULL);
}


/* ---------------------------- */

static void
amtape_taper_scan(G_GNUC_UNUSED int argc, G_GNUC_UNUSED char ** argv) {
    char *label = NULL;
    char * searchlabel;
    tape_t * tp;
    char *timestamp = NULL;
    char *tapedev = NULL;

    device_api_init();
    
    fprintf(stderr, _("%s: scanning for "), get_pname());

    tp = lookup_last_reusable_tape(0);
    if (tp == NULL) {
        searchlabel = NULL;
    } else {
	searchlabel = stralloc(tp->label);
        fprintf(stderr, _("tape label %s or "), searchlabel);
    }
    fprintf(stderr, _("a new tape.\n"));

    taper_scan(searchlabel, &label, &timestamp, &tapedev,
               FILE_taperscan_output_callback, stderr, NULL, NULL);

    fprintf(stderr, _("%s: label %s is now loaded.\n"),
            get_pname(), label);


    amfree(searchlabel);
    amfree(label);
    amfree(timestamp);
    amfree(tapedev);
}

/* ---------------------------- */

static void
show_device(G_GNUC_UNUSED int	argc,
            G_GNUC_UNUSED char ** argv) {
    char *slot = NULL, *device = NULL;
    
    if(changer_loadslot(_("current"), &slot, &device)) {
	error(_("Could not load current slot.\n"));
	/*NOTREACHED*/
    }

    printf("%s\n", device);
    amfree(slot);
    amfree(device);
}
