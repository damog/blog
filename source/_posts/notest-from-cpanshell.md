title: "notest from CPAN::Shell"
date: 2009/9/15 10:11:37
tags:
- cpan
- perl
- planeta linux
---
I implemented a simple <a href="http://github.com/axiombox/planetalinux/blob/master/installdeps.pl">dependencies installer</a> for the <a href="http://github.com/axiombox/planetalinux">new Planeta Linux</a>. I spent some time trying to find how to make <a href="http://search.cpan.org/~andk/CPAN-1.9402/lib/CPAN.pm#CPAN::Shell">CPAN::Shell</a>::install to install modules without running the test units, it's quite simple.

[Perl]
CPAN::Shell->rematein("notest", "install", $module);
[/Perl]

Kudos to <a href="http://www.shadowcat.co.uk/blog/matt-s-trout/">mst</a> for the pointer.