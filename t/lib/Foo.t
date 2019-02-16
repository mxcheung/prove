use strict;
use warnings;
use 5.010;

use Test::More;

use Foo;

main();

sub main {

	test_object_creation();

}

sub test_object_creation {
	note('Test Object Creation');
	my $obj = Foo->new( 'High' => 42, 'Low' => 11 );
	isa_ok( $obj, 'Foo' );

	is( ref($obj), 'Foo', "Reference Type is Record." );

}

sub test_foo_array {
	note('Test Foo Array');
	my $foo1 = Foo->new( 'High' => 42, 'Low' => 11 );
	my $foo2 = Foo->new( 'High' => 45, 'Low' => 9 );
	my $foo3 = Foo->new( 'High' => 41, 'Low' => 9 );
	my @foos = ( $foo1, $foo2 );
	push @foos, $foo3;

	for my $foo (@foos) {
		print "$foo\n";
	}
}

done_testing();
