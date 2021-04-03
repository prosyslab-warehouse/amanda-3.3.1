# This file was automatically generated by SWIG (http://www.swig.org).
# Version 2.0.4
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.

package Amanda::Header;
use base qw(Exporter);
use base qw(DynaLoader);
package Amanda::Headerc;
bootstrap Amanda::Header;
package Amanda::Header;
@EXPORT = qw();

# ---------- BASE METHODS -------------

package Amanda::Header;

sub TIEHASH {
    my ($classname,$obj) = @_;
    return bless $obj, $classname;
}

sub CLEAR { }

sub FIRSTKEY { }

sub NEXTKEY { }

sub FETCH {
    my ($self,$field) = @_;
    my $member_func = "swig_${field}_get";
    $self->$member_func();
}

sub STORE {
    my ($self,$field,$newval) = @_;
    my $member_func = "swig_${field}_set";
    $self->$member_func($newval);
}

sub this {
    my $ptr = shift;
    return tied(%$ptr);
}


# ------- FUNCTION WRAPPERS --------

package Amanda::Header;

*C_from_string = *Amanda::Headerc::C_from_string;

############# Class : Amanda::Header::Header ##############

package Amanda::Header::Header;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Amanda::Header );
%OWNER = ();
%ITERATORS = ();
*swig_type_get = *Amanda::Headerc::Header_type_get;
*swig_type_set = *Amanda::Headerc::Header_type_set;
*swig_datestamp_get = *Amanda::Headerc::Header_datestamp_get;
*swig_datestamp_set = *Amanda::Headerc::Header_datestamp_set;
*swig_dumplevel_get = *Amanda::Headerc::Header_dumplevel_get;
*swig_dumplevel_set = *Amanda::Headerc::Header_dumplevel_set;
*swig_compressed_get = *Amanda::Headerc::Header_compressed_get;
*swig_compressed_set = *Amanda::Headerc::Header_compressed_set;
*swig_encrypted_get = *Amanda::Headerc::Header_encrypted_get;
*swig_encrypted_set = *Amanda::Headerc::Header_encrypted_set;
*swig_comp_suffix_get = *Amanda::Headerc::Header_comp_suffix_get;
*swig_comp_suffix_set = *Amanda::Headerc::Header_comp_suffix_set;
*swig_encrypt_suffix_get = *Amanda::Headerc::Header_encrypt_suffix_get;
*swig_encrypt_suffix_set = *Amanda::Headerc::Header_encrypt_suffix_set;
*swig_name_get = *Amanda::Headerc::Header_name_get;
*swig_name_set = *Amanda::Headerc::Header_name_set;
*swig_disk_get = *Amanda::Headerc::Header_disk_get;
*swig_disk_set = *Amanda::Headerc::Header_disk_set;
*swig_program_get = *Amanda::Headerc::Header_program_get;
*swig_program_set = *Amanda::Headerc::Header_program_set;
*swig_application_get = *Amanda::Headerc::Header_application_get;
*swig_application_set = *Amanda::Headerc::Header_application_set;
*swig_srvcompprog_get = *Amanda::Headerc::Header_srvcompprog_get;
*swig_srvcompprog_set = *Amanda::Headerc::Header_srvcompprog_set;
*swig_clntcompprog_get = *Amanda::Headerc::Header_clntcompprog_get;
*swig_clntcompprog_set = *Amanda::Headerc::Header_clntcompprog_set;
*swig_srv_encrypt_get = *Amanda::Headerc::Header_srv_encrypt_get;
*swig_srv_encrypt_set = *Amanda::Headerc::Header_srv_encrypt_set;
*swig_clnt_encrypt_get = *Amanda::Headerc::Header_clnt_encrypt_get;
*swig_clnt_encrypt_set = *Amanda::Headerc::Header_clnt_encrypt_set;
*swig_recover_cmd_get = *Amanda::Headerc::Header_recover_cmd_get;
*swig_recover_cmd_set = *Amanda::Headerc::Header_recover_cmd_set;
*swig_uncompress_cmd_get = *Amanda::Headerc::Header_uncompress_cmd_get;
*swig_uncompress_cmd_set = *Amanda::Headerc::Header_uncompress_cmd_set;
*swig_decrypt_cmd_get = *Amanda::Headerc::Header_decrypt_cmd_get;
*swig_decrypt_cmd_set = *Amanda::Headerc::Header_decrypt_cmd_set;
*swig_srv_decrypt_opt_get = *Amanda::Headerc::Header_srv_decrypt_opt_get;
*swig_srv_decrypt_opt_set = *Amanda::Headerc::Header_srv_decrypt_opt_set;
*swig_clnt_decrypt_opt_get = *Amanda::Headerc::Header_clnt_decrypt_opt_get;
*swig_clnt_decrypt_opt_set = *Amanda::Headerc::Header_clnt_decrypt_opt_set;
*swig_cont_filename_get = *Amanda::Headerc::Header_cont_filename_get;
*swig_cont_filename_set = *Amanda::Headerc::Header_cont_filename_set;
*swig_dle_str_get = *Amanda::Headerc::Header_dle_str_get;
*swig_dle_str_set = *Amanda::Headerc::Header_dle_str_set;
*swig_is_partial_get = *Amanda::Headerc::Header_is_partial_get;
*swig_is_partial_set = *Amanda::Headerc::Header_is_partial_set;
*swig_partnum_get = *Amanda::Headerc::Header_partnum_get;
*swig_partnum_set = *Amanda::Headerc::Header_partnum_set;
*swig_totalparts_get = *Amanda::Headerc::Header_totalparts_get;
*swig_totalparts_set = *Amanda::Headerc::Header_totalparts_set;
*swig_blocksize_get = *Amanda::Headerc::Header_blocksize_get;
*swig_blocksize_set = *Amanda::Headerc::Header_blocksize_set;
*swig_orig_size_get = *Amanda::Headerc::Header_orig_size_get;
*swig_orig_size_set = *Amanda::Headerc::Header_orig_size_set;
sub new {
    my $pkg = shift;
    my $self = Amanda::Headerc::new_Header(@_);
    bless $self, $pkg if defined($self);
}

*to_string = *Amanda::Headerc::Header_to_string;
*debug_dump = *Amanda::Headerc::Header_debug_dump;
*summary = *Amanda::Headerc::Header_summary;
sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Amanda::Headerc::delete_Header($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


############# Class : Amanda::Header::HeaderXML ##############

package Amanda::Header::HeaderXML;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Amanda::Header );
%OWNER = ();
%ITERATORS = ();
*swig_disk_get = *Amanda::Headerc::HeaderXML_disk_get;
*swig_disk_set = *Amanda::Headerc::HeaderXML_disk_set;
*swig_device_get = *Amanda::Headerc::HeaderXML_device_get;
*swig_device_set = *Amanda::Headerc::HeaderXML_device_set;
*swig_program_is_application_api_get = *Amanda::Headerc::HeaderXML_program_is_application_api_get;
*swig_program_is_application_api_set = *Amanda::Headerc::HeaderXML_program_is_application_api_set;
*swig_program_get = *Amanda::Headerc::HeaderXML_program_get;
*swig_program_set = *Amanda::Headerc::HeaderXML_program_set;
*swig_estimatelist_get = *Amanda::Headerc::HeaderXML_estimatelist_get;
*swig_estimatelist_set = *Amanda::Headerc::HeaderXML_estimatelist_set;
*swig_spindle_get = *Amanda::Headerc::HeaderXML_spindle_get;
*swig_spindle_set = *Amanda::Headerc::HeaderXML_spindle_set;
*swig_compress_get = *Amanda::Headerc::HeaderXML_compress_get;
*swig_compress_set = *Amanda::Headerc::HeaderXML_compress_set;
*swig_encrypt_get = *Amanda::Headerc::HeaderXML_encrypt_get;
*swig_encrypt_set = *Amanda::Headerc::HeaderXML_encrypt_set;
*swig_kencrypt_get = *Amanda::Headerc::HeaderXML_kencrypt_get;
*swig_kencrypt_set = *Amanda::Headerc::HeaderXML_kencrypt_set;
*swig_levellist_get = *Amanda::Headerc::HeaderXML_levellist_get;
*swig_levellist_set = *Amanda::Headerc::HeaderXML_levellist_set;
*swig_nb_level_get = *Amanda::Headerc::HeaderXML_nb_level_get;
*swig_nb_level_set = *Amanda::Headerc::HeaderXML_nb_level_set;
*swig_dumpdate_get = *Amanda::Headerc::HeaderXML_dumpdate_get;
*swig_dumpdate_set = *Amanda::Headerc::HeaderXML_dumpdate_set;
*swig_compprog_get = *Amanda::Headerc::HeaderXML_compprog_get;
*swig_compprog_set = *Amanda::Headerc::HeaderXML_compprog_set;
*swig_srv_encrypt_get = *Amanda::Headerc::HeaderXML_srv_encrypt_get;
*swig_srv_encrypt_set = *Amanda::Headerc::HeaderXML_srv_encrypt_set;
*swig_clnt_encrypt_get = *Amanda::Headerc::HeaderXML_clnt_encrypt_get;
*swig_clnt_encrypt_set = *Amanda::Headerc::HeaderXML_clnt_encrypt_set;
*swig_srv_decrypt_opt_get = *Amanda::Headerc::HeaderXML_srv_decrypt_opt_get;
*swig_srv_decrypt_opt_set = *Amanda::Headerc::HeaderXML_srv_decrypt_opt_set;
*swig_clnt_decrypt_opt_get = *Amanda::Headerc::HeaderXML_clnt_decrypt_opt_get;
*swig_clnt_decrypt_opt_set = *Amanda::Headerc::HeaderXML_clnt_decrypt_opt_set;
*swig_record_get = *Amanda::Headerc::HeaderXML_record_get;
*swig_record_set = *Amanda::Headerc::HeaderXML_record_set;
*swig_create_index_get = *Amanda::Headerc::HeaderXML_create_index_get;
*swig_create_index_set = *Amanda::Headerc::HeaderXML_create_index_set;
*swig_auth_get = *Amanda::Headerc::HeaderXML_auth_get;
*swig_auth_set = *Amanda::Headerc::HeaderXML_auth_set;
*swig_exclude_file_get = *Amanda::Headerc::HeaderXML_exclude_file_get;
*swig_exclude_file_set = *Amanda::Headerc::HeaderXML_exclude_file_set;
*swig_exclude_list_get = *Amanda::Headerc::HeaderXML_exclude_list_get;
*swig_exclude_list_set = *Amanda::Headerc::HeaderXML_exclude_list_set;
*swig_include_file_get = *Amanda::Headerc::HeaderXML_include_file_get;
*swig_include_file_set = *Amanda::Headerc::HeaderXML_include_file_set;
*swig_include_list_get = *Amanda::Headerc::HeaderXML_include_list_get;
*swig_include_list_set = *Amanda::Headerc::HeaderXML_include_list_set;
*swig_exclude_optional_get = *Amanda::Headerc::HeaderXML_exclude_optional_get;
*swig_exclude_optional_set = *Amanda::Headerc::HeaderXML_exclude_optional_set;
*swig_include_optional_get = *Amanda::Headerc::HeaderXML_include_optional_get;
*swig_include_optional_set = *Amanda::Headerc::HeaderXML_include_optional_set;
*swig_application_property_get = *Amanda::Headerc::HeaderXML_application_property_get;
*swig_application_property_set = *Amanda::Headerc::HeaderXML_application_property_set;
*swig_scriptlist_get = *Amanda::Headerc::HeaderXML_scriptlist_get;
*swig_scriptlist_set = *Amanda::Headerc::HeaderXML_scriptlist_set;
*swig_data_path_get = *Amanda::Headerc::HeaderXML_data_path_get;
*swig_data_path_set = *Amanda::Headerc::HeaderXML_data_path_set;
*swig_directtcp_list_get = *Amanda::Headerc::HeaderXML_directtcp_list_get;
*swig_directtcp_list_set = *Amanda::Headerc::HeaderXML_directtcp_list_set;
*swig_next_get = *Amanda::Headerc::HeaderXML_next_get;
*swig_next_set = *Amanda::Headerc::HeaderXML_next_set;
sub new {
    my $pkg = shift;
    my $self = Amanda::Headerc::new_HeaderXML(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Amanda::Headerc::delete_HeaderXML($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


# ------- VARIABLE STUBS --------

package Amanda::Header;

*F_UNKNOWN = *Amanda::Headerc::F_UNKNOWN;
*F_WEIRD = *Amanda::Headerc::F_WEIRD;
*F_TAPESTART = *Amanda::Headerc::F_TAPESTART;
*F_TAPEEND = *Amanda::Headerc::F_TAPEEND;
*F_DUMPFILE = *Amanda::Headerc::F_DUMPFILE;
*F_CONT_DUMPFILE = *Amanda::Headerc::F_CONT_DUMPFILE;
*F_SPLIT_DUMPFILE = *Amanda::Headerc::F_SPLIT_DUMPFILE;
*F_EMPTY = *Amanda::Headerc::F_EMPTY;

@EXPORT_OK = ();
%EXPORT_TAGS = ();


=head1 NAME

Amanda::Header - Amanda-specific headers prepended to dump files

=head1 SYNOPSIS

  # create a header
  my $hdr = Amanda::Header->new();
  $hdr->{type} = $Amanda::Header::F_DUMPFILE;
  $hdr->{name} = "localhost";
  $hdr->{disk} = "/home";

  # make a string suitable for use in a dumpfile (NUL-padded)
  my $block = $hdr->to_string(32768, 32768);

  # parse a string into a header
  $hdr = Amanda::Header->from_string($block);

  print "Working on: ", $hdr->summary(), "\n";

=head1 Header Objects

Note that, due to the vagaries of SWIG wrapping, headers actually have
class C<Amanda::Header::Header>.

The constructor creates a new, blank header, which will need at least
some of its attributes set before being used.  These are set just like
any hashref-based object:

 $hdr->{'dumplevel'} = 13;

To construct a new object from a bytestring (as read from the
beginning of a dumpfile), use

 Amanda::Header->from_string($data);

To convert a header object into a bytestring, use the C<to_string(min,
max)> method.  This method takes a minimum and maximum size.  If the
header is smaller than the minimum size, it is padded with NUL bytes;
if it would be larger than the maximum size, the method returns
C<undef>.

The C<summary> method returns a single-line summary of the header, with
no trailing newline.

As a debugging utility, the C<debug_dump> method dumps the contents of
the object to the debug log.

To compare a header to a list of dumpspecs (see L<Amanda::Cmdline>), use

  if ($hdr->matches_dumpspecs([@dumpspecs])) { ... }

which is really a call to C<Amanda::Cmdline::header_matches_dumpspecs>.

A header object has the following keys:

 type
 datestamp
 dumplevel
 compressed
 encrypted
 comp_suffix
 encrypt_suffix
 name               hostname (F_DUMPFILE) or label (F_TAPESTART)
 disk
 program
 application
 srvcompprog
 clntcompprog
 srv_encrypt
 clnt_encrypt
 recover_cmd
 uncompress_cmd
 decrypt_cmd
 srv_decrypt_opt
 clnt_decrypt_opt
 cont_filename
 dle_str
 is_partial
 partnum
 totalparts         (-1 == UNKNOWN)
 blocksize
 orig_size

C<type> is one of the following constants, which are availble for
import in the tag C<:constants>:

 F_UNKNOWN
 F_WEIRD
 F_TAPESTART
 F_TAPEEND
 F_DUMPFILE
 F_CONT_DUMPFILE
 F_SPLIT_DUMPFILE
 F_EMPTY
 F_NOOP

Some of the header fields are interrelated.  The following restrictions apply.

=over 4

=item *

C<comp_suffix> is set if and only if C<compressed> is true; the suffix "N" is
reserved and cannot be used.

=item *

C<encrypt_suffix> is set if and only if C<encrypted> is true; the suffix "N" is
reserved and cannot be used.

=item *

If C<totalparts> is not -1, then C<partnum> must be less than or equal to
C<totalparts>.  Neither parameter can be zero.  These parameters are only
recorded in a C<F_SPLIT_DUMPFILE> header.

=item *

The C<blocksize> is intended for the user's convenience only.  It is written to
the header string, but not parsed on return.  C<from_string> will always return
a header with blocksize=0.

=item *

Like C<blocksize>, C<recover_cmd>, C<uncompress_cmd> and C<decrypt_cmd> are
intended for the user's convenience noly.  The C<uncompress_cmd> and
C<decrypt_cmd>, if specified, must end with C<|> (the shell pipe character).
Neither can be nonempty unless C<recover_cmd> is also nonempty.  When parsing a
header with only two commands from a string, it is ambiguous whether the first
string is for decryption or uncompression, and this package assumes
uncompression.

=back

=cut



push @EXPORT_OK, qw(filetype_t_to_string);
push @{$EXPORT_TAGS{"filetype_t"}}, qw(filetype_t_to_string);

my %_filetype_t_VALUES;
#Convert an enum value to a single string
sub filetype_t_to_string {
    my ($enumval) = @_;

    for my $k (keys %_filetype_t_VALUES) {
	my $v = $_filetype_t_VALUES{$k};

	#is this a matching flag?
	if ($enumval == $v) {
	    return $k;
	}
    }

#default, just return the number
    return $enumval;
}

push @EXPORT_OK, qw($F_UNKNOWN);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_UNKNOWN);

$_filetype_t_VALUES{"F_UNKNOWN"} = $F_UNKNOWN;

push @EXPORT_OK, qw($F_WEIRD);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_WEIRD);

$_filetype_t_VALUES{"F_WEIRD"} = $F_WEIRD;

push @EXPORT_OK, qw($F_TAPESTART);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_TAPESTART);

$_filetype_t_VALUES{"F_TAPESTART"} = $F_TAPESTART;

push @EXPORT_OK, qw($F_TAPEEND);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_TAPEEND);

$_filetype_t_VALUES{"F_TAPEEND"} = $F_TAPEEND;

push @EXPORT_OK, qw($F_DUMPFILE);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_DUMPFILE);

$_filetype_t_VALUES{"F_DUMPFILE"} = $F_DUMPFILE;

push @EXPORT_OK, qw($F_CONT_DUMPFILE);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_CONT_DUMPFILE);

$_filetype_t_VALUES{"F_CONT_DUMPFILE"} = $F_CONT_DUMPFILE;

push @EXPORT_OK, qw($F_SPLIT_DUMPFILE);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_SPLIT_DUMPFILE);

$_filetype_t_VALUES{"F_SPLIT_DUMPFILE"} = $F_SPLIT_DUMPFILE;

push @EXPORT_OK, qw($F_EMPTY);
push @{$EXPORT_TAGS{"filetype_t"}}, qw($F_EMPTY);

$_filetype_t_VALUES{"F_EMPTY"} = $F_EMPTY;

#copy symbols in filetype_t to constants
push @{$EXPORT_TAGS{"constants"}},  @{$EXPORT_TAGS{"filetype_t"}};


# SWIG produces a sub-package for the Header "class", in this case named
# Amanda::Header::Header.  For user convenience, we allow Amanda::Header->new(..) to
# do the same thing.  This is a wrapper function, and not just a typeglob assignment,
# because we want to get the right blessing.
sub new {
    shift; # ignore class
    Amanda::Header::Header->new(@_);
}

sub from_string {
    shift; # ignore class
    return C_from_string(@_);
}

sub get_dle {
    my $self = shift;

    return Amanda::Header::HeaderXML->new($self->{'dle_str'});
}

package Amanda::Header::Header;

# point $hdr->matches_dumpspecs() to Amanda::Cmdline::header_matches_dumpspecs.  When
# Amanda is built with --without-server, Amanda::Cmdline is missing, so this will fail.
# Note that this assumes the user has already use'd Amanda::Cmdline.
sub matches_dumpspecs {
    Amanda::Cmdline::header_matches_dumpspecs(@_);
}

package Amanda::Header;
1;
