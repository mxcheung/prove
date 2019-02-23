@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl
#line 15

# Copyright 2002-2018, Paul Johnson (paul@pjcj.net)

# This software is free.  It is licensed under the same terms as Perl itself.

# The latest version of this software should be available from my homepage:
# http://www.pjcj.net

use 5.26.0;
use warnings;

our $VERSION = '1.31'; # VERSION

use Devel::Cover::Collection;

use Cwd qw( abs_path cwd );
use Fcntl ":flock";
use Getopt::Long;
use Pod::Usage;

# use Carp; $SIG{__DIE__} = \&Carp::confess;

$|++;

my $Options = {
    bin_dir               => abs_path($0) =~ s|/cpancover$||r,
    build                 => 1,
    compress_old_versions => 0,
    docker                => "docker",
    dryrun                => 0,
    force                 => 0,
    generate_html         => 0,
    latest                => 0,
    local                 => 0,
    local_build           => 0,
    modules               => [],
    output_file           => "index.html",
    report                => "html_basic",
    results_dir           => cwd(),
    timeout               => 7200,  # two hours
    verbose               => 0,
    workers               => 0,
};

sub get_options {
    die "Bad option" unless GetOptions($Options, qw(
        bin_dir=s
        build!
        compress_old_versions=i
        docker=s
        dryrun!
        force!
        generate_html!
        help|h!
        info|i!
        latest!
        local!
        local_build!
        module_file=s
        modules=s
        output_file=s
        report=s
        results_dir=s
        timeout=i
        verbose!
        version|v!
        workers=i
    ));

    say "$0 version " . __PACKAGE__->VERSION and exit 0 if $Options->{version};
    pod2usage(-exitval => 0, -verbose => 0)             if $Options->{help};
    pod2usage(-exitval => 0, -verbose => 2)             if $Options->{info};
}

sub newcp {
    Devel::Cover::Collection->new(
        map { $_ => $Options->{$_} } qw(
            bin_dir
            docker
            dryrun
            force
            local
            modules
            output_file
            report
            results_dir
            timeout
            verbose
            workers
        )
    )
}

sub main {
    # TODO - only one instance should run at a time
    get_options;

    if ($Options->{latest}) {
        my $cp = newcp;
        $cp->get_latest;
        return;
    }

    if ($Options->{local_build}) {
        my $cp = newcp;
        $cp->set_modules(@ARGV);
        $cp->local_build;
        return;
    }

    if ($Options->{module_file}) {
        my $cp = newcp;
        $cp->set_module_file($Options->{module_file});
        $cp->cover_modules;
    }

    if ($Options->{build}) {
        if (@ARGV) {
            my $cp = newcp;
            $cp->set_modules(@ARGV);
            $cp->cover_modules;
        } elsif (! -t STDIN) {
            my @modules;
            while (<>) {
                chomp;
                push @modules, split;
            }
            my $cp = newcp;
            $cp->set_modules(@modules);
            $cp->cover_modules;
        } else {
            my $cp = newcp;
            $cp->cover_modules;
        }
    }

    if ($Options->{generate_html}) {
        my $cp = newcp;
        $cp->generate_html;
    }

    if ($Options->{compress_old_versions}) {
        my $cp = newcp;
        $cp->compress_old_versions($Options->{compress_old_versions});
    }
}

main

__END__

=head1 NAME

cpancover - report coverage statistics on CPAN modules

=head1 VERSION

version 1.31

=head1 SYNOPSIS

 cpancover -help -info -version
           -collect -redo_cpancover_html -redo_html -force -dryrun
           -modules module_name
           -results_dir /path/to/dir
           -outputdir /path/to/dir
           -outputfile filename.html
           -report report_name
           -generate_html
           -compress_old_versions number_to_keep
           -local

=head1 DESCRIPTION

=head1 OPTIONS

The following command line options are supported:

 -h -help               - show help
 -i -info               - show documentation
 -v -version            - show version
 -collect               - collect coverage from modules       (on)
 -directory             - location of the modules             ($cwd)
 -dryrun                - don't execute (for some commands)   (off)
 -force                 - recollect coverage                  (off)
 -modules               - modules to use                      (all in $dir)
 -outputdir             - where to store output               ($directory)
 -outputfile            - top level index                     (coverage.html)
 -redo_cpancover_html   - don't set default modules           (off)
 -redo_html             - force html generation for modules   (off)
 -report                - report to use                       (html_basic)
 -generate_html         - generate html                       (off)
 -compress_old_versions - compress data older than n versions (3)
 -local                 - use local (uninstalled) code        (off)

=head1 DETAILS

=head1 REQUIREMENTS

Collect coverage for results and create html, csv and json output.

The modules L<Template> and L<Parallel::Iterator> are required.

=head1 EXIT STATUS

The following exit values are returned:

0   All operations were completed successfully.

>0  An error occurred.

=head1 SEE ALSO

 L<Devel::Cover>

=head1 BUGS

 Undocumented.

=head1 LICENCE

Copyright 2002-2018, Paul Johnson (paul@pjcj.net)

This software is free.  It is licensed under the same terms as Perl itself.

The latest version of this software should be available from my homepage:
http://www.pjcj.net

=cut

__END__
:endofperl
