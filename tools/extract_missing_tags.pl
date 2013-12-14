use strict;
use warnings;

use Alstublieft::Blog;
use Data::Dumper;

my $blog = Alstublieft::Blog->new(
    publish_path => '../publish'
);

for my $post ( @{ $blog->posts } ) {
    my @tags = $post->tags;
    next if @tags;

    print Dumper [
        $post->filename, \@tags
    ];
}


