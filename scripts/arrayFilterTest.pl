use strict;
use warnings;
use Data::Dumper;

my @AoH = (
    { start => 30, end => 55, },
    { start => 18, end => 21, },
    { start => 30, end => 80, }
);

print Dumper \@AoH;

my @filtered = grep { $_->{start} > 40 or $_->{end} < 60 } @AoH;
print Dumper \@filtered;