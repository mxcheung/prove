# Copyright 2001-2018, Paul Johnson (paul@pjcj.net)

# This software is free.  It is licensed under the same terms as Perl itself.

# The latest version of this software should be available from my homepage:
# http://www.pjcj.net

# This file was automatically generated by Makefile.PL.

package Devel::Cover::Inc;

use strict;
use warnings;

our $VERSION      = "1.31";
our $Perl_version = '5.028000';
our @Inc          = qw( . C:/Strawberry/perl/lib C:/Strawberry/perl/site/lib C:/Strawberry/perl/site/lib/MSWin32-x64-multi-thread C:/Strawberry/perl/vendor/lib );
chomp (our $Perl  = <<'EOV');  # Careful with \\ in the path
C:\Strawberry\perl\bin\perl.exe
EOV

if ($Perl_version ne $]) {
    print STDERR <<"EOM";

This version of Devel::Cover was built with Perl version $Perl_version.
It is now being run with Perl version $].
Attempting to make adjustments, but you may find that some of your modules do
not have coverage data collected.  You may need to alter the +-inc, +-ignore
and +-select options.

EOM
    eval "use Cwd";
    my %inc = map { -d $_ ? (($_ eq "." ? $_ : Cwd::abs_path($_)) => 1) : () }
                   @INC;
    @Inc = sort keys %inc;
}

# TODO - check for threadedness, 64bits etc. ?

1
