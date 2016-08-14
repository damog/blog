title: "notest from CPAN::Shell"
date: 2009/9/15 10:11:37
tags:
- cpan
- perl
- planeta linux
---
I implemented a simple [dependencies installer](http://github.com/planetalinux/planetalinux/blob/master/installdeps.pl) for the [new Planeta Linux](http://github.com/planetalinux/planetalinux). I spent some time trying to find how to make [CPAN::Shell](https://metacpan.org/pod/CPAN#CPAN::Shell)::install to install modules without running the test units, it's quite simple.

    CPAN::Shell->rematein("notest", "install", $module);

Kudos to [mst](http://shadow.cat/blog/matt-s-trout/) for the pointer.
