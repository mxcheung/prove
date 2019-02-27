package FileIdempRepo;
use strict;
use warnings;
use 5.010;
use Data::Dumper;

sub new {
	my ( $class, %args ) = @_;
	my $self = { base_dir => $args{'base_dir'} };

	print Dumper( \%args );
	print "$args{'High'}\n";
	print "$args{'base_dir'}\n";
	return bless $self, $class;
}

sub index_doc {
	my ( $self, $index ) = @_;

	print "indexing document ........\n";
	print Dumper( \$index );
	print "$index->{type}\n";
	print "$index->{index}\n";
	print "$index->{body}->{content}\n";
	print "$index->{body}->{title}\n";
	$self->{index} = $index;
	print "self:: $self->{index}->{body}->{title}\n";
	return;
}

1;
