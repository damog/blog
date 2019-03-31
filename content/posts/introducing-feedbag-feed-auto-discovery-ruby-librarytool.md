---
title: "Introducing Feedbag: Feed auto-discovery Ruby library/tool"
date: 2008-12-30 18:58:10
tag:
- feed
- feedbag
- ruby
- web
---
Last week, I spent some time building a good (that I liked) feed auto-discovery tool to use in Ruby for other project I'm building, <a href="http://github.com/damog/rfeed">rFeed</a>. I liked CPAN's [Feed::Find](https://metacpan.org/pod/Feed::Find), and at some point I made a wrapper class to run a Perl script using such module, however, I wasn't happy by mixing it all. So, <a href="http://github.com/damog/feedbag">Feedbag</a> was born:

    >> require "rubygems"
    => true
    >> require "feedbag"
    => true
    >> Feedbag.find "damog.net"
    => ["http://feeds.feedburner.com/TeoremaDelCerdoInfinito",
     "http://damog.net/comments/feed/"]
    >> planet_feeds = Feedbag.find("planet.debian.org")
    [ ... ]
    >> planet_feeds.first(3)
    => ["http://planet.debian.org/rss10.xml",
     "http://planet.debian.org/rss20.xml",
     "http://planet.debian.org/atom.xml"]
    >> planet_feeds.size
    => 104
    >>

It makes smart use of relative and absolute bases, hrefs, links, content types, etc. It is also a single Ruby file, so you can grab it and use it on your application. Plus, it only requires <a href="https://code.whytheluckystiff.net/hpricot/">Hpricot</a> as dependency. It can find all feeds linked on a web page, but it will return the most important at the beginning of the resulting array, so you will have the important one on the first results (see example above with Planet Debian).

Please take a look at the <a href="http://github.com/damog/feedbag">git repo</a>, hosted in <a href="http://github.com/">GitHub</a>.
