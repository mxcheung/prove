use strict;
use warnings;
use 5.010;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../../lib";

use FileIdempRepo;



main();

sub main {

   test_object_creation();
   test_index_document();
   test_get_document();
   test_serialize();
   test_deserialize();
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
  id    => 1,
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
   my $expected = "index=my_apptype=blog_postid=1title=Elasticsearch clientsdate=2013-09-24SW50ZXJlc3RpbmcgY29udGVudC4uLg==";
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
   my $got = $filerepo->deserialize($index);
   my $expected = $index;
   is_deeply  ($got, $expected);
   return;
}



done_testing();

1;
