use strict;
use warnings;
use Data::Dumper;

# Index a document:

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

# Get the document:

my $get = {
	index => 'my_app',
	type  => 'blog_post',
	id    => 1
};

print $index->{index};
print $index->{type};
print "***************************\n";
print $get->{index};
