package FileRepository;
use strict;
use warnings;
use 5.010;
use Data::Dumper;


sub new {
	my ( $class, %params) = @_;
	my $self   = {
		base_dir   => $params{'base_dir'}
	};
	
	print Dumper(\%params);
	
	print "$params{'High'}\n";
    print "$params{'base_dir'}\n";
	
	bless $self, $class;

}

sub index_doc {
	my ( $self,  $index) = @_;
	
	print "indexing document ........\n";
	print Dumper(\$index);
	print "$index->{type}\n";
	print "$index->{index}\n";
	print "$index->{body}->{content}\n";
	print "$index->{body}->{title}\n";
}
1;