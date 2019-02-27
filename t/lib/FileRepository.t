use strict;
use warnings;
use 5.010;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../../lib";

use FileRepository;

main();

sub main {

	test_object_creation();

}

sub test_object_creation {
	note('Test Object Creation');
	my $obj = FileRepository->new( 'High' => 42, 'Low' => 11 );
	isa_ok( $obj, 'FileRepository' );

	is( ref($obj), 'FileRepository', "Reference Type is Record." );

}



done_testing();
