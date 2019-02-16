use strict;
use warnings;
use Data::Dumper;

my @data = (
	{
		id   => '1',
		name => 'Tom',
		sex  => 'Male',
	},
	{
		id   => '2',
		name => 'Harry',
		sex  => 'Male',
	},
	{
		id   => '3',
		name => 'Pam',
		sex  => 'Female',
	},
	{
		id   => '4',
		name => 'Dick',
		sex  => 'Male',
	}
);

# print Dumper \@data;

my @filtered = grep { $_->{name} eq "Dick" } @data;
print Dumper \@filtered;