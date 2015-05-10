Title: Perl on the NYMag
Date: 2009-08-10 09:21:33
Tags: feed,perl,xml
---
Reading <a href="http://www.google.com/reader/shared/02195294431377468397">my morning load of feed news</a>, I spotted an interesting bit on the <a href="http://nymag.com">New York Magazine</a> <a href="http://nymag.com/rss/Travel.xml">travel feed</a>:

<img class="aligncenter size-full wp-image-928" title="Picture 18" src="http://damog.net/old/axiombox/2009/08/Picture-18.png" alt="Picture 18" width="503" height="327" />

Of course, someone's doing something wrong there, but I'd say it's their usage of <a href="http://search.cpan.org/dist/XML-Feed/">XML::Feed</a> (my guess on what they are using since the generator tag is omitted), by not dereferencing that hash reference or trying to forcibly stringify it.

Of course that comes from the feed itself:

<img class="aligncenter size-full wp-image-929" title="Picture 20" src="http://damog.net/old/axiombox/2009/08/Picture-20.png" alt="Picture 20" width="217" height="301" />

It's awesome, and nothing new of course, that big publications and organizations are using Perl to process and offer data to users, but I find it always super cool when they make it so obvious :)