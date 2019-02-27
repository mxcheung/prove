package FileIdempRepo;
use strict;
use warnings;
use 5.010;
use Data::Dumper;

sub new {
	my ( $class, %args ) = @_;
	my %repo;
	$repo{'apple'} = 'red';
	$repo{'banana'} = 'yellow';
	my $self = { base_dir => $args{'base_dir'},
	             repo => \%repo
               };

	print Dumper( \%args );
	print "$args{'High'}\n";
	print "$args{'base_dir'}\n";
	return bless $self, $class;
}

sub index_doc {
	my ( $self, $request ) = @_;

	print "indexing document ........\n";
	print Dumper( \$request );
	$self->{request} = $request;
	print "self:: $self->{request}->{body}->{title}\n";
	my $index = $request->{index};
	my $id = $request->{id};
	my $key = $index.'-' . $id;
	my $body = $request->{body};
	
	$self->{'repo'}->{$key} = $body;
	return $self;
}

sub get_doc {
	my ( $self, $request ) = @_;
	my $index = $request->{index};
	my $id = $request->{id};
	my $key = $index.'-' . $id;
	print "getting document ........\n";
	my $body = $self->{'repo'}->{$key}; 
	print Dumper( \$body );
	return $body;
}

1;
