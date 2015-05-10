Title: Feedbag 0.6
Date: 2010-03-05 20:36:59
Tags: feedbag,gemcutter,github,ruby,rubygems
---
I just uploaded <a href="http://axiombox.com/feedbag">Feedbag</a> 0.6 to <a href="http://rubygems.org/gems/feedbag/versions/0.6">Gemcutter</a> and <a href="http://github.com/damog/feedbag">GitHub</a>.

Just a couple of small nice additions to this version:
<ul>
	<li>The undocumented <tt>args[:narrow]</tt> option has been disabled until further notice.</li>
	<li>A nice little commit from <a href="http://github.com/damog/feedbag/commit/ad7fdaf671b039cac5550b89d20de511b9a2bb14">one</a> of Feedbag's forks, by Patrick Reagan.</li>
	<li>Added an executable to find feed URLs directly:</li>
</ul>
Sometimes you need to find the feed for a URL quickly, not from a script. What I do, and what someone else showed me too, is this:

<code lang="bash">
~ $ irb
-- require "rubygems"
= true
-- require "feedbag"
= true
-- Feedbag.find "http://stereonaut.net"
= ["http://stereonaut.net/feed", "http://stereonaut.net/tag/feed/", "http://stereonaut.net/comments/feed/"]
-- 
</code>

But now you can simply do:

<code lang="bash">
~ $ feedbag cnn.com http://twitter.com/compupaisa
== cnn.com:
 - http://rss.cnn.com/rss/cnn_topstories.rss
 - http://rss.cnn.com/rss/cnn_latest.rss
== http://twitter.com/compupaisa:
 - http://twitter.com/statuses/user_timeline/119479806.rss
 - http://twitter.com/favorites/119479806.rss
~ $ 
</code>

Enjoy the <tt>feedbag</tt> executable on your <tt>$PATH</tt> now!