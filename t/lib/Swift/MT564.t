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
 print "===================================";
 print Dumper( \@rows );
 print "===================================";
 my %swift_msg = (
  "Corporate action reference"       => "CA1234",
  "Corporate action event indicator" => "MEET",
  "Mandatory/voluntary indicator"    => "MAND",
  "Meeting date"                     => "20190316",
  "Announcement date"                => "20190312",
  "Record date"                      => "20190318",
  "Ex-dividend or distribution date" => "20190516",
 );
 my $rows      = \@rows;
 my $swift_msg = \%swift_msg;

 print "=========  main sectiib ==========================\n";
 my @filteredrows = $obj->enrich_data( { rows => $rows, swift_msg => $swift_msg } );
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
