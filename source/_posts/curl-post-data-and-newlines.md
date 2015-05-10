title: "curl POST data and newlines"
Date: 2010-08-15 22:10:35
Tags: code,curl,debian,rails
---
I'm writing a <a href="http://rubyonrails.org/">Rails</a> application for the <a href="http://en.wikipedia.org/wiki/Microblogging">microblogging</a> strategy for <a href="http://debian.org">Debian</a> (which I used to call, <a href="http://github.com/damog/debian-twitter">debian-twitter</a>, but you know how us Debian folks are :D). I came up with a strange issue, that at first I thought was <a href="http://guides.rubyonrails.org/action_controller_overview.html">ActionController</a>'s fault or some crap.

So, I was testing one of my controllers with something like this:

<code lang="bash">cat /tmp/mm.txt | curl -d @- http://localhost:3000/message/new</code>

/tmp/mm.txt is a <a href="http://en.wikipedia.org/wiki/Pretty_Good_Privacy">PGP</a> signed message which then I just send as POST data to my application. So far so good. However, when accessing the data from Rails, using request.body.read, I was a getting a single line, with the newlines (carriage returns) removed. So I started looking at how ActionController was getting the HTTP data and stuff. But then I tested:

<code lang="bash">cat /tmp/mm.txt | lwp-request -m POST  http://localhost:3000/message/new</code>

And that had the carriage returns in place.

So, I started looking at the curl man page and discovered this little gem:
<blockquote>--data-binary &lt;data&gt;

(HTTP) This posts data exactly as specified with no extra processing whatsoever.

If you start the data with the letter @, the rest should be a filename. Data is posted in a similar manner as --data-ascii does, except that newlines are preserved and conversions are never done.

If this option is used several times, the ones following the first will append data as described in -d/--data.</blockquote>
<code lang="bash">cat /tmp/mm.txt | curl --data-binary @- http://localhost:3000/message/new</code>

...did indeed the tricky. Maybe someone needs this info some day.