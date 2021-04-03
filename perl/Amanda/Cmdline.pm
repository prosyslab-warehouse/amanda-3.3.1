# This file was automatically generated by SWIG (http://www.swig.org).
# Version 2.0.4
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.

package Amanda::Cmdline;
use base qw(Exporter);
use base qw(DynaLoader);
package Amanda::Cmdlinec;
bootstrap Amanda::Cmdline;
package Amanda::Cmdline;
@EXPORT = qw();

# ---------- BASE METHODS -------------

package Amanda::Cmdline;

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

package Amanda::Cmdline;

*format_dumpspec_components = *Amanda::Cmdlinec::format_dumpspec_components;
*parse_dumpspecs = *Amanda::Cmdlinec::parse_dumpspecs;
*header_matches_dumpspecs = *Amanda::Cmdlinec::header_matches_dumpspecs;

############# Class : Amanda::Cmdline::dumpspec_t ##############

package Amanda::Cmdline::dumpspec_t;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Amanda::Cmdline );
%OWNER = ();
%ITERATORS = ();
*swig_host_get = *Amanda::Cmdlinec::dumpspec_t_host_get;
*swig_host_set = *Amanda::Cmdlinec::dumpspec_t_host_set;
*swig_disk_get = *Amanda::Cmdlinec::dumpspec_t_disk_get;
*swig_disk_set = *Amanda::Cmdlinec::dumpspec_t_disk_set;
*swig_datestamp_get = *Amanda::Cmdlinec::dumpspec_t_datestamp_get;
*swig_datestamp_set = *Amanda::Cmdlinec::dumpspec_t_datestamp_set;
*swig_level_get = *Amanda::Cmdlinec::dumpspec_t_level_get;
*swig_level_set = *Amanda::Cmdlinec::dumpspec_t_level_set;
*swig_write_timestamp_get = *Amanda::Cmdlinec::dumpspec_t_write_timestamp_get;
*swig_write_timestamp_set = *Amanda::Cmdlinec::dumpspec_t_write_timestamp_set;
sub new {
    my $pkg = shift;
    my $self = Amanda::Cmdlinec::new_dumpspec_t(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Amanda::Cmdlinec::delete_dumpspec_t($self);
        delete $OWNER{$self};
    }
}

*format = *Amanda::Cmdlinec::dumpspec_t_format;
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

package Amanda::Cmdline;

*CMDLINE_PARSE_DATESTAMP = *Amanda::Cmdlinec::CMDLINE_PARSE_DATESTAMP;
*CMDLINE_PARSE_LEVEL = *Amanda::Cmdlinec::CMDLINE_PARSE_LEVEL;
*CMDLINE_EMPTY_TO_WILDCARD = *Amanda::Cmdlinec::CMDLINE_EMPTY_TO_WILDCARD;

@EXPORT_OK = ();
%EXPORT_TAGS = ();


=head1 NAME

Amanda::Cmdline - utilities for handling command lines

=head1 SYNOPSIS

  use Amanda::Cmdline;

  my $spec = Amanda::Cmdline::dumpspec_t->new($host, $disk, $datestamp, $level, $write_timestamp);
  print "host: $spec->{'host'}; disk: $spec->{'disk'}\n";

  my @specs = Amanda::Cmdline::parse_dumpspecs(["host", "disk", "date"],
			    $Amanda::Cmdline::CMDLINE_PARSE_DATESTAMP);

=head1 Amanda::Cmdline::dumpspec_t Objects

Note that this class was called C<Amanda::Cmdline::dumpspec_t> in older versions;
that name will still work, but is deprecated.

=head2 Keys

Each key contains a match expression, in the form of a string, or undef.  Note
that the values of these keys are read-only.

=over

=item C<< $ds->{'host'} >>

Hostname

=item C<< $ds->{'disk'} >>

Disk name

=item C<< $ds->{'datestamp'} >>

Dump timestamp.

=item C<< $ds->{'level'} >>

Dump level

=item C<< $ds->{'write_timestamp'} >>

Timestamp when the dump is written to storage media.

=back

=head2 Methods

=over

=item C<< $ds->format() >>

Format the dumpspec as a string.

=back

=head1 Package Functions

=over

=item C<format_dumpspec_components($host, $disk, $datestamp, $level)>

This function returns a string representing the formatted form of the
given dumpspec.  This formatting is the same as performed by
C<< $ds->format() >>, but does not need a C<Dumpspec>.

=item C<parse_dumpspecs([@cmdline], $flags)>

This function parses C<@cmdline> into a list of C<Dumpspec> objects,
according to C<$flags>, which is a logical combination of zero or more
of

 $CMDLINE_PARSE_DATESTAMP - recognize datestamps
 $CMDLINE_PARSE_LEVEL - recognize levels
 $CMDLINE_EMPTY_TO_WILDCARD - if @cmdline is empty, make a wildcard dumpspec

These constants are available in export tag C<:constants>.  The command-line
format is

  [host [disk [datestamp [level [host [..]]]]]]

Note that there is no facility for specifying C<write_timestamp> on the command
line.

=item C<header_matches_dumpspecs($hdr, [@dumpspecs])>

This function compares a header to a list of dumpspecs, returning true if the
header matches at least one dumpspec.  If C<@dumpspecs> is empty, the function
returns false.

=back

=head1 SEE ALSO

L<Amanda::Config> handles C<-o> options itself, through
C<config_overrides>.

=cut



push @EXPORT_OK, qw(cmdline_parse_dumpspecs_flags_to_strings);
push @{$EXPORT_TAGS{"cmdline_parse_dumpspecs_flags"}}, qw(cmdline_parse_dumpspecs_flags_to_strings);

my %_cmdline_parse_dumpspecs_flags_VALUES;
#Convert a flag value to a list of names for flags that are set.
sub cmdline_parse_dumpspecs_flags_to_strings {
    my ($flags) = @_;
    my @result = ();

    for my $k (keys %_cmdline_parse_dumpspecs_flags_VALUES) {
	my $v = $_cmdline_parse_dumpspecs_flags_VALUES{$k};

	#is this a matching flag?
	if (($v == 0 && $flags == 0) || ($v != 0 && ($flags & $v) == $v)) {
	    push @result, $k;
	}
    }

#by default, just return the number as a 1-element list
    if (!@result) {
	return ($flags);
    }

    return @result;
}

push @EXPORT_OK, qw($CMDLINE_PARSE_DATESTAMP);
push @{$EXPORT_TAGS{"cmdline_parse_dumpspecs_flags"}}, qw($CMDLINE_PARSE_DATESTAMP);

$_cmdline_parse_dumpspecs_flags_VALUES{"CMDLINE_PARSE_DATESTAMP"} = $CMDLINE_PARSE_DATESTAMP;

push @EXPORT_OK, qw($CMDLINE_PARSE_LEVEL);
push @{$EXPORT_TAGS{"cmdline_parse_dumpspecs_flags"}}, qw($CMDLINE_PARSE_LEVEL);

$_cmdline_parse_dumpspecs_flags_VALUES{"CMDLINE_PARSE_LEVEL"} = $CMDLINE_PARSE_LEVEL;

push @EXPORT_OK, qw($CMDLINE_EMPTY_TO_WILDCARD);
push @{$EXPORT_TAGS{"cmdline_parse_dumpspecs_flags"}}, qw($CMDLINE_EMPTY_TO_WILDCARD);

$_cmdline_parse_dumpspecs_flags_VALUES{"CMDLINE_EMPTY_TO_WILDCARD"} = $CMDLINE_EMPTY_TO_WILDCARD;

#copy symbols in cmdline_parse_dumpspecs_flags to constants
push @{$EXPORT_TAGS{"constants"}},  @{$EXPORT_TAGS{"cmdline_parse_dumpspecs_flags"}};

push @EXPORT_OK, qw(header_matches_dumpspecs parse_dumpspecs format_dumpspec_components);
1;
