package Foo;
use strict;
use warnings;
use 5.010;

use base 'Exporter';
our @EXPORT_OK = qw(compute);

sub new {
	my $type = shift;

   #I still don't see how I can just turn an array into a hash and expect things
   #to work out for me.
	my %params = @_;
	my $self   = [];

	#Exactly where did params{'Left'} and params{'Right'} come from?
	$self->[0] = $params{'Left'};
	$self->[1] = $params{'Right'};

	#and again with the bless.
	bless $self, $type;

}

1;
