use strict;
use warnings;
use 5.010;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../../lib";
use Data::Dumper;
use FileIdempRepo;

use constant   SOH   =>  "\x01";

main();

sub main {

  # test_object_creation();
  # test_index_document();
  # test_get_document();
  # test_serialize();
   test_deserialize();
  # test_find_lines();
   test_convert_lines();
   return;
}

sub test_object_creation {
  note('Test Object Creation');
   my $obj = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
   isa_ok( $obj, 'FileIdempRepo' );
   is( ref($obj), 'FileIdempRepo', "Reference Type is Record." );
   my $expected = "c:\\temp\\repo";
   my $got = $obj->{base_dir};
   is  ($got, $expected, "test base_dir is set");
   return;
}

sub test_index_document {
 note('Test index document');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );

 my $index = {
  index => 'my_app',
  type  => 'blog_post',
  id    => 3,
  body  => {
   title   => 'Elasticsearch clients',
   content => 'Interesting content...',
   date    => '2013-09-24'
  }
 };
 my $self = { filerepo => $filerepo };
 $self->{filerepo}->index_doc($index);
 return;
}

sub test_get_document {
 note('Test get document');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
	 my $index = {
	  index => 'my_app',
	  type  => 'blog_post',
	  id    => 1,
	  body  => {
	   title   => 'Elasticsearch clients',
	   content => 'Interesting content...',
	   date    => '2013-09-24'
	  }
	 };
	 my $get = {
	  index => 'my_app',
	  type  => 'blog_post',
	  id    => 1
	 };
   my $self = { filerepo => $filerepo };
   $self->{filerepo}->index_doc($index);
   $self->{filerepo}->get_doc($get);
 
 return;
}

sub test_serialize {
 note('Test serialize');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
	 my $index = {
	  index => 'my_app',
	  type  => 'blog_post',
	  id    => 1,
	  body  => {
	   title   => 'Elasticsearch clients',
	   content => 'Interesting content...',
	   date    => '2013-09-24'
	  }
	 };
   my $expected = "index=my_apptype=blog_postid=1title=Elasticsearch clientsdate=2013-09-24content=SW50ZXJlc3RpbmcgY29udGVudC4uLg==";
   my $got = $filerepo->serialize($index);
   is  ($got, $expected, "test deserialized data");
   return;
}

sub test_deserialize {
 note('Test deserialize');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
	 my $index = {
	  index => 'my_app',
	  type  => 'blog_post',
	  id    => 1,
	  body  => {
	   title   => 'Elasticsearch clients',
	   content => 'Interesting content...',
	   date    => '2013-09-24'
	  }
	 };
   my $line = "index=my_apptype=blog_postid=1title=Elasticsearch clientsdate=2013-09-24content=SW50ZXJlc3RpbmcgY29udGVudC4uLg==";
   my $got = $filerepo->deserialize($line);
   my $expected = $index;
   is_deeply  ($got, $expected);
   return;
}

sub test_find_lines {
 note('Test find lines document');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
 my $base_dir = 'c:\\temp\\repo';
 my $file =  $base_dir."\\file.txt";
  my $keyword = SOH."id=2".SOH;
 my @lines = $filerepo->find_lines($file, $keyword);
# print Dumper( \@lines );
 
 return;
}

sub test_convert_lines {
 note('Test find lines document');
 my $filerepo = FileIdempRepo->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
 my $base_dir = 'c:\\temp\\repo';
 my $file =  $base_dir."\\file.txt";
  my $keyword = SOH."id=3".SOH;
 my @lines = $filerepo->find_lines($file, $keyword);
 my @data = $filerepo->convert_lines(@lines);
 print Dumper( \@data );
 
 return;
}

done_testing();

1;
