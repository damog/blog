title: "Feedbag 0.6"
date: 2010/3/5 20:36:59
tags:
- feedbag
- gemcutter
- github
- ruby
- rubygems
---
I just uploaded Feedbag 0.6 to <a href="http://rubygems.org/gems/feedbag/versions/0.6">Gemcutter</a> and <a href="http://github.com/damog/feedbag">GitHub</a>.

Just a couple of small nice additions to this version:

- The undocumented `args[:narrow]` option has been disabled until further notice.
- A nice little commit from <a href="http://github.com/damog/feedbag/commit/ad7fdaf671b039cac5550b89d20de511b9a2bb14">one</a> of Feedbag's forks, by Patrick Reagan.
- Added an executable to find feed URLs directly.

Sometimes you need to find the feed for a URL quickly, not from a script. What I do, and what someone else showed me too, is this:

    ~ $ irb
    -- require "rubygems"
    = true
    -- require "feedbag"
    = true
    -- Feedbag.find "http://stereonaut.net"
    = ["http://stereonaut.net/feed", "http://stereonaut.net/tag/feed/", "http://stereonaut.net/comments/feed/"]
    --

But now you can simply do:

    ~ $ feedbag cnn.com http://twitter.com/compupaisa
    == cnn.com:
     - http://rss.cnn.com/rss/cnn_topstories.rss
     - http://rss.cnn.com/rss/cnn_latest.rss
    == http://twitter.com/compupaisa:
     - http://twitter.com/statuses/user_timeline/119479806.rss
     - http://twitter.com/favorites/119479806.rss
    ~ $

Enjoy the `feedbag` executable on your `$PATH` now!
