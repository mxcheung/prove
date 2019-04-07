use strict;
use warnings;
use 5.010;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../../../lib";
use Data::Dumper;

use Swift::MT564;

main();

sub main {
 test_object_creation();
 test_load_data();

 return;
}

sub test_object_creation {
 note('Test Object Creation');
 my $obj = MT564->new( 'base_dir' => 'c:\\temp\\repo' );
 isa_ok( $obj, 'MT564' );
 return;
}

sub test_load_data {
 note('Test load_data');
 my $obj = MT564->new( 'base_dir' => 'c:\\temp\\repo' );
 isa_ok( $obj, 'MT564' );
 my @rows = $obj->load_data( { 'base_dir' => 'c:\\temp\\repo' } );
# print "===================================";
# print Dumper( \@rows );

 
  my %swift_msg = %{$obj->swift_msg( { 'dummy' => 'dummy' } )};
 
 
 my $rows      = \@rows;
 my $swift_msg = \%swift_msg;

 my @rows = $obj->enrich_data( { rows => $rows, swift_msg => $swift_msg } );

 print "=========  main section ==========================\n";
 my @filteredrows = $obj->main_section( { rows => \@rows } );
 print Dumper(@filteredrows);
 
 print "=========  response_date ==========================\n";
 my $response_date = $obj->response_date( { rows => \@rows } );
 print Dumper($response_date);
 print "=========  date range==========================\n";
 my $result = $obj->process_start_end_date( { rows => \@rows } );
 print Dumper($result);
 return;
}

done_testing();

1;
