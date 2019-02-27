use strict;
use warnings;
use 5.010;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../../lib";

use FileRepository;

main();

sub main {

	test_object_creation();
    test_index_document();
}

sub test_object_creation {
	note('Test Object Creation');
	my $obj = FileRepository->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );
	isa_ok( $obj, 'FileRepository' );

	is( ref($obj), 'FileRepository', "Reference Type is Record." );

}

sub test_index_document {
	note('Test index document');
	my $filerepo = FileRepository->new( 'base_dir' => 'c:\\temp\\repo', 'High' => 42, 'Low' => 11 );

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
	my $self = {
		filerepo => $filerepo
	};
	$self->{filerepo}->index_doc($index);

}




done_testing();
