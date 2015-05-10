Title: Introducing Feedbag: Feed auto-discovery Ruby library/tool
Date: 2008-12-30 18:58:10
Tags: feed,feedbag,ruby,web
---
Last week, I spent some time building a good (that I liked) feed auto-discovery tool to use in Ruby for other project I'm building, <a href="http://github.com/damog/rfeed">rFeed</a>. I liked CPAN's <a href="http://search.cpan.org/~btrott/Feed-Find-0.06/lib/Feed/Find.pm">Feed::Find</a>, and at some point I made a wrapper class to run a Perl script using such module, however, I wasn't happy by mixing it all. So, <a href="http://axiombox.com/feedbag">Feedbag</a> was born:
<pre><code>&gt;&gt; require "rubygems"
=&gt; true
&gt;&gt; require "feedbag"
=&gt; true
&gt;&gt; Feedbag.find "log.damog.net"
=&gt; ["http://feeds.feedburner.com/TeoremaDelCerdoInfinito", 
 "http://log.damog.net/comments/feed/"]</code><span class="go">
</span><code>&gt;&gt; planet_feeds = Feedbag.find("planet.debian.org")
[ ... ]
&gt;&gt; planet_feeds.first(3)
=&gt; ["http://planet.debian.org/rss10.xml", 
 "http://planet.debian.org/rss20.xml", 
 "http://planet.debian.org/atom.xml"]
&gt;&gt;</code><code> planet_feeds.size
=&gt; 104
&gt;&gt;</code></pre>
It makes smart use of relative and absolute bases, hrefs, links, content types, etc. It is also a single Ruby file, so you can grab it and use it on your application. Plus, it only requires <a href="https://code.whytheluckystiff.net/hpricot/">Hpricot</a> as dependency. It can find all feeds linked on a web page, but it will return the most important at the beginning of the resulting array, so you will have the important one on the first results (see example above with Planet Debian).

Synopsis, README and a brief tutorial have been placed at <a href="http://axiombox.com/feedbag">axiombox.com/feedbag</a>. You can also take a look at the <a href="http://github.com/damog/feedbag">git repo</a>, hosted in <a href="http://github.com/">GitHub</a>.