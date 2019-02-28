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
    my $base_dir = $self->{base_dir};
    my $file =  $base_dir."\\file.txt";
    open(my $fd, ">>$file") or die "Couldn't open: $!";
	my $data = serialize($self, $request);
    print $fd "$data\n";
    close $fd;
    my $keyword = SOH."id=2".SOH;
    find_lines($self, $file, $keyword);
	return $self;
}

sub find_lines {
   my @lines;
   my ( $self, $file, $keyword) = @_;
    open my $fh, '<:encoding(UTF-8)', $file or die;
    while (my $line = <$fh>) {
        if ($line =~ /$keyword/) {
         #   print $line;
            push @lines, $line;
        }
    }
    close $fh;
    return @lines;
}

sub convert_lines {
   my ( $self, @lines) = @_;
   my @data;
   for my $line (@lines) {
  #    print "$line\n";
      my $obj =  deserialize($self, $line);
      push @data, $obj;

    }
    return @data;
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
	my $data = "index=".$index.SOH."type=".$type.SOH."id=".$id.SOH."title=".$title.SOH."date=".$date.SOH."content=".$encoded;
    return $data;
}

sub deserialize {
   my ( $self, $line ) = @_;
   my %elements = map{split /\=/, $_}(split /\x01/, $line);
   my $request = {
	  index => $elements{index},
	  type  =>  $elements{type},
	  id    => $elements{id},
	  body  => {
	   title   =>  $elements{title},
	   content => decode_base64($elements{content}),
	   date    => $elements{date}
	  }
	 };
 #   print Dumper( \$request );
    return $request;
}

1;
