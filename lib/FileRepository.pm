package FileRepository;
use strict;
use warnings;
use 5.010;
use Data::Dumper;


sub new {
	my ( $class, %params) = @_;
	my $self   = [];
	
	print Dumper(\%params);
	
	print "$params{'High'}\n";
	
	
	bless $self, $class;

}

1;