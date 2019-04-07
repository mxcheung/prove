package MT564;
use strict;
use warnings;

use 5.010;
use Data::Dumper;
use Date::Calc qw[check_date Add_Delta_Days];

# Object interface
use Text::CSV_XS;

sub new {
 my ( $class, %params ) = @_;
 my $self = { base_dir => $params{'base_dir'} };

 print Dumper( \%params );

 return bless $self, $class;
}

sub load_data {
 my ( $self, $params ) = @_;
 print "loading data \n";
 my $file = "$FindBin::Bin/data/swift.csv";
 print "loading $file \n";

 open my $fh, "<", $file or die "$file: $!";
 my $csv = Text::CSV_XS->new( { binary => 1, auto_diag => 1 } );
 $csv->column_names( $csv->getline($fh) );    # use header
 my @rows = ();
 while ( my $row = $csv->getline_hr($fh) ) {
#  printf "Tag: %-32s Qualifier: %s Field Name: %s\n",
#    $row->{Tag}, $row->{Qualifier}, $row->{'Field Name'};
  push @rows, $row;
 }
 close $fh;

 return @rows;
}

sub swift_msg {
 my ( $self, $params ) = @_;
 
  my %swift_msg = (
  "Corporate action reference"       => corporate_action_reference(),
  "Corporate action event indicator" => corporate_action_event_indicator(),
  "Mandatory/voluntary indicator"    => "MAND",
  "Meeting date"                     => "20190316",
  "Announcement date"                => announcement_date(),
  "Record date"                      => record_date(),
  "Ex-dividend or distribution date" => ex_date(),
 );
 return \%swift_msg;
}

sub corporate_action_event_indicator {
 return "MEET";
}


sub corporate_action_reference {
 return "CA1235";
}

sub record_date {
 return "20190717";
}

sub ex_date {
 return "20190521";
}

sub announcement_date {
 return "20190315";
}


sub enrich_data {
 my ( $self, $params ) = @_;
 my @rows      = @{ $params->{rows} };
 my %swift_msg = %{ $params->{swift_msg} };
 foreach my $row (@rows) {
  my $key = $row->{'Field Name'};
  $row->{'Field Value'} = $swift_msg{$key};
 }
 return @rows;
}

sub main_section {
 my ( $self, $params ) = @_;
 my @filteredrows = filter_main_section( $params->{rows}, 800  );
 return @filteredrows;
}


sub response_date {
 my ( $self, $params ) = @_;
 my @filteredrows = filter_section( $params->{rows}, 999  );
 my $response_by_date = '';
 foreach my $row (@filteredrows) {
  my $fv = $row->{'Field Value'};
  $response_by_date = add_days_to_date( $fv, $row->{'Parameters'} )   if ( defined $row->{'Field Value'} );
 }
 return { '$response_by_date' => $response_by_date };
}

sub process_start_end_date {
 my ( $self, $params ) = @_;
 my @filteredrows =  filter_section( $params->{rows}, 998  );
 my @dates = ();
 foreach my $row (@filteredrows) {
  push @dates, $row->{'Field Value'}  if ( $row->{'Field Value'} );
 }
 my ($min) = sort @dates;
 my ($max) = reverse sort @dates;
 return { 'min' => $min, 'max' => $max };
}

sub filter_main_section {
 my ($rows, $filterValue ) = @_;
 my @rows = @{$rows};
 my @filteredrows = ();
 foreach my $row (@rows) {
  push @filteredrows, $row if $row->{Item} <= $filterValue;
 }
 return @filteredrows;
}


sub filter_section {
 my ($rows, $filterValue ) = @_;
 my @rows = @{$rows};
 my @filteredrows = ();
 foreach my $row (@rows) {
  push @filteredrows, $row if $row->{Item} == $filterValue;
 }
 return @filteredrows;
}

sub add_days_to_date {
 my ( $date, $offset ) = @_;
 sprintf '%d%02d%02d',  Add_Delta_Days( $date =~ /(\d{4})(\d{2})(\d{2})/, $offset );
}

1;
