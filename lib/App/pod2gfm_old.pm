# TODO:
#   Fix --target-directory not using basename; otherwise nested paths fail.
#   Perhaps add shell completions; some opts have default values to put in comps.
#   Maybe use new Class.
#   Add tests.

package App::pod2gfm;

use v5.40.0;

use strict;
use warnings;

use File::Basename qw< basename >;
use File::Spec     ();
use Getopt::Long   qw<
    GetOptionsFromArray
    :config
    gnu_getopt
    no_ignore_case
>;
use Pod::Usage;
use Pod::Markdown::Githubert;
use DDP;  # TODO: Remove (debugging only).

our $VERSION = 'v1.0.0';

my $PROG = basename($0);

sub new ($class)
{
    my $self = bless {}, $class;
    return $self;
}

sub init ( $self, @argv )
{
    _exit( $self->_process_opts( \@argv ) );

    return $self;
}

sub run ($self)
{
    p $self;
    while ( $self->{argv}->@* ) {
        p $self->{argv};
        $self->_convert_md if $self->_set_handles == 0;
    }

    p $self;
    return 0;
}

sub _process_opts ( $self, $argv = undef )
{
    return 0 unless defined $argv;

    # Transform Getopt::Long error warns.
    local $SIG{__WARN__} = sub {
        chomp( my $msg = shift );

        $msg =~ tr{"}{'};
        $msg = lcfirst $msg;

        warn "$PROG: $msg\n";
    };

    # Pod::Markdown::Githubert options
    $self->{gh_opts} = {
        output_encoding => 'UTF-8',
    };

    GetOptionsFromArray(
        $argv,
        'a|auto'               => \$self->{opts}{auto},
        'file-extension|e=s'   => \$self->{opts}{file_ext},
        'no-strip-ext'         => \$self->{opts}{no_strip_ext},
        'target-directory|t=s' => \$self->{opts}{target_dir},
        'force'                => \$self->{opts}{force},
        'hl-language=s'        => \$self->{gh_opts}{hl_language},
        'man-url-prefix=s'     => \$self->{gh_opts}{man_url_prefix},
        'perldoc-url-prefix=s' => \$self->{gh_opts}{perldoc_url_prefix},
        'h|help'               => sub { pod2usage( -exitval => 0, -verbose => 0 ) },
        'v|version'            => sub { print "$PROG $VERSION\n"; exit 0 },

    ) or return 2;

    $self->{argv} = $argv;

    foreach my ( $k, $v ) ( $self->{gh_opts}->%* ) {
        delete $self->{gh_opts}{$k} unless defined $v;
    }

    return 0;
}

sub _set_handles ($self)
{
    my ( $in_fh, $infile ) = $self->_get_infile;
    my $out_fh = $self->_get_outfile($infile);

    return 1 if !fileno $out_fh && $out_fh == 1;

    # Return only bytes to avoid PERL_UNICODE effects.
    binmode $_, ':bytes' foreach ( $in_fh, $out_fh );

    $self->{infile}  = $in_fh;
    $self->{outfile} = $out_fh;

    return 0;
}

sub _get_infile ($self)
{
    my $in_fh;
    my $infile = shift $self->{argv}->@*;

    if ( !defined $infile || $infile eq '-' ) {
        $in_fh = *STDIN;  # Read STDIN.
    }
    else {
        open my $fh, '<', $infile
          or do {
              warn "$PROG: failed to open '$infile': $!\n";
              exit 1;
          };

        $in_fh = $fh;
    }

    return ( $in_fh, $infile );
}

sub _get_outfile ( $self, $infile )
{
    my $out_fh;
    my $auto = $self->{opts}{auto};

    my $outfile =
        $auto
      ? $infile
      : shift $self->{argv}->@*;

    if ( !defined $outfile && !$auto ) {
        $out_fh = *STDOUT;  # Print to STDOUT.
    }
    else {
        if ($auto) {
            my $target_dir = $self->{opts}{target_dir};

            my $auto_file =
                $self->{opts}{no_strip_ext}
              ? $infile
              : $infile =~ s{\.(?> pm | pod | pl)\z}{}xr;  # Strip extension.

            my $ext = $self->{opts}{file_ext} // 'md';

            $outfile = basename("$auto_file.$ext");
            $outfile =
              defined $target_dir
              ? File::Spec->catdir( $target_dir, $outfile )
              : $outfile;
        }

        if ( -f $outfile && !$self->{opts}{force} ) {
            warn "$PROG: $outfile file exists; use --force to overwrite it\n";
            return 1;
        }

        open my $fh, '>', $outfile
          or do {
              warn "$PROG: failed to open '$outfile': $!\n";
              exit 1;
          };

        $out_fh = $fh;
    }

    return $out_fh;
}

sub _convert_md ($self)
{
    my $parser = Pod::Markdown::Githubert->new( $self->{gh_opts}->%* );

    $parser->output_fh( $self->{outfile} );
    $parser->parse_file( $self->{infile} );

    return $self;
}

sub _exit ($code)
{
    exit $code if $code > 0;
}

=encoding UTF-8

=for highlighter language=perl

=head1 NAME

App::pod2gfm - core implementation for pod2gfm

=head1 SYNOPSIS

  use App::pod2gfm;

  App::pod2gfm->new->init(@ARGV)->run;

=head1 DESCRIPTION

B<App::pod2gfm> provides the logic behind the L<pod2gfm> wrapper script, handling
options processing and filehandles before calling L<Pod::Markdown::Githubert>.
See L<pod2gfm/DESCRIPTION> for details.

Note that unlike L<pod2markdown>, this module does not deal with some options such
as encodings, and uses UTF-8 by default. Also, it supports writing to multiple
files and does not overwrite existing ones.

=head1 METHODS

=head2 new

  my $pod2gfm = App::pod2gfm->new;

Constructs and returns a new B<App::pod2gfm> instance. Takes no arguments.

=head2 init

  $pod2gfm->init(@ARGV);

Parses the list given (typically from C<@ARGV>) for options. Returns C<self>.

=head2 run

  $pod2gfm->run;

Performs the program actions: sets the filehandles according to the command-line
arguments, then passes them to L<Pod::Markdown::Githubert> to do the conversion.
Takes no arguments and returns C<0> on success.

=head1 ERRORS

This module reports errors to C<STDERR> and exits with a non‑zero status in the
following:

=over 4

=item * File access/permission issues.

=item * Invalid command-line options.

=back

See L<pod2gfm/EXIT-STATUS> for exit code details.

=head1 BUGS

Report bugs at L<https://github.com/ryoskzypu/App-pod2gfm/issues>.

=head1 AUTHOR

ryoskzypu <ryoskzypu@proton.me>

=head1 SEE ALSO

=over 4

=item *

L<Pod::Markdown>

=item *

L<Pod::Markdown::Githubert>

=back

=head1 COPYRIGHT

Copyright © 2026 ryoskzypu

MIT-0 License. See LICENSE for details.

=cut
