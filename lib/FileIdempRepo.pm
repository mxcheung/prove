package FileIdempRepo;
use strict;
use warnings;
use 5.010;
use Data::Dumper;
use MIME::Base64;

use constant   SOH   =>  "\x01";


sub new {
	my ( $class, %args ) = @_;
	my %repo;
	$repo{'apple'} = 'red';
	$repo{'banana'} = 'yellow';
	my $self = { base_dir => $args{'base_dir'},
	             repo => \%repo
               };

#	print Dumper( \%args );
#	print "$args{'High'}\n";
#	print "$args{'base_dir'}\n";
	return bless $self, $class;
}

sub index_doc {
	my ( $self, $request ) = @_;

#	print "indexing document ........\n";
#	print Dumper( \$request );
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
#	print "getting document ........\n";
	my $body = $self->{'repo'}->{$key}; 
#	print Dumper( \$body );
	return $body;
}

sub serialize {
    my ( $self, $request ) = @_;
    my $index = $request->{index};
    my $type = $request->{type};
	my $id = $request->{id};
	my $title = $request->{body}->{title};
	my $content = $request->{body}->{content};
	my $encoded = encode_base64($content, "");
	my $date = $request->{body}->{date};
#	print "zzzzzzzzzzzzzzzzzzzzzzz\n";
#	print "$index\n";
#	print "$type\n";
	my $data = "index=".$index.SOH."type=".$type.SOH."id=".$id.SOH."title=".$title.SOH."date=".$date.SOH.$encoded;
#	print "$data\n";
#	print "zzzzzzzzzzzzzzzzzzzzzzz\n";
    return $data;
}

sub deserialize {
    my $data  = shift; 
    
    my @pieces = split /\x01/, $data;
    
    my $request = {
	  index => 'my_app',
	  type  => 'blog_post',
	  id    => 1,
	  body  => {
	   title   => 'Elasticsearch clients',
	   content => 'Interesting content...',
	   date    => '2013-09-24'
	  }
	 };
  #  my $request = "";
  #  my $index = $request->{index};
#	my $id = $request->{id};
	
    return $request;
}

1;
