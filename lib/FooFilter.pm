package FooFilter;
use strict;
use warnings;
use 5.010;
use Data::Dumper;
use base 'Exporter';
use Foo;

main();

sub main {

	my $foo1 = Foo->new( 'High' => 42, 'Low' => 11 );
	my $foo2 = Foo->new( 'High' => 45, 'Low' => 9 );
	my $foo3 = Foo->new( 'High' => 41, 'Low' => 9 );
	my @foos = ( $foo1, $foo2 );
	push @foos, $foo3;

	for my $foo (@foos) {

	}

	my %person = (
		fname => 'Foo',
		lname => 'Bar'
	);

	print "person $person{'fname'}";

	my %phones = (
		Foo => '1-234',
		Bar => '1-456',
	);
	my $hr = \%phones;

	say $phones{Foo};    # 1-234
	say $hr->{Foo};      # 1-234

	my $other_ref1 = {
		Qux => '1-567',
		Moo => '1-890',
	};

	say "=========================";
	my $xx = $other_ref1->{'Qux'};    # 1-567
	say " $xx";
	say "=========================";
	my $other_ref2 = {
		Qux => '1-11567',
		Moo => '1-890',
	};

	my @otherList = ( $other_ref1, $other_ref2 );

}

1;
