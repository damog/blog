---
title: "Ruby goodies: Modules and methods for my everyday Ruby"
date: 2009-01-03 23:27:50
tag:
- gem
- github
- ruby
---
I make a lot of Web script processing, whether scraping, webservices, systems administration, etc. Because I sometimes happen to repeat small and useful chunks of code for different projects, I thought that, given making new modules and methods is usually hassleless in Ruby, I should make my own set of methods and goodies I constantly use. Example 1, I sometimes miss Perl's LWP::Simple simplicity where I just pass a URL to a subroutine and get the content on a variable, quick, one-liner. Example 2, extract all links on a given URL on an array that I can then iterate and maybe fetch given the first example. Getting all A links is very easy to do, say with regex or with Hpricot (which should the best way to parse HTML), but most of the time I (and people, I'd bet) need absolute URLs which is fairly more complex (relative, absolute URLs, BASE href declarations, etc, the same case as in <a href="http://github.com/damog/feedbag">Feedbag</a>).

Well, for different cases like that one, I've started my own set of Ruby goodies. If you don't find them useful, I understand, they are mostly for my <strongown</strong> needs, I just want to make it public, because maybe, some other people might indeed find them useful.

Simple installation:

    sudo gem install damog-goodies -s http://gems.github.com/

As time and needs pass, I will be adding stuff into it. For the time being, here's both above examples in action:

    >> require "goodies"
    requiring /var/lib/gems/1.8/gems/damog-goodies-0.1/lib/goodies/array.rb
    requiring /var/lib/gems/1.8/gems/damog-goodies-0.1/lib/goodies/lwr.rb
    requiring /var/lib/gems/1.8/gems/damog-goodies-0.1/lib/goodies/html.rb
    => true
    >> pp HTML::Links.find "damog.net"
    ["mailto:david-YOUKNOWTHEDEAL-axiombox.com",
     "http://damog.net/",
     "http://historiasdenuevayork.com",
     "http://axiombox.com/",
     "http://flickr.com/photos/raquelydavid",
     "http://last.fm/user/damog",
     "http://twitter.com/mrdamog",
     "http://www.facebook.com/profile.php?id=670490388",
     "http://www.chess.com?ref_id=1380378",
     "http://www.chess.com",
     "http://www.chess.com/members/view/damog?ref_id=1380378",
     "http://www.chess.com/echess/create_game.html?uid=1380378&ref_id=1380378",
     "http://www.chess.com/home/game_archive.html?member=damog&ref_id=1380378"]
    => nil
    >> pp HTML::Links.find("http://google.com").first(10)
    ["http://images.google.com/imghp?hl=en&tab=wi",
     "http://maps.google.com/maps?hl=en&tab=wl",
     "http://news.google.com/nwshp?hl=en&tab=wn",
     "http://www.google.com/prdhp?hl=en&tab=wf",
     "http://mail.google.com/mail/?hl=en&tab=wm",
     "http://www.google.com/intl/en/options/",
     "http://video.google.com/?hl=en&tab=wv",
     "http://groups.google.com/grphp?hl=en&tab=wg",
     "http://books.google.com/bkshp?hl=en&tab=wp",
     "http://scholar.google.com/schhp?hl=en&tab=ws"]
    => nil
    >> get "debian.org"
    [snip]
    >> get("planeta.debian.net")[0, 100]
    => "<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"
    >>

Repository is, as usual, kindly hosted at <a href="http://github.com">GitHub</a> on <a href="http://github.com/damog/goodies">damog/goodies</a>.
