title: "Feedbag now using feedvalidator"
date: 2009/2/11 16:00:53
tags:
- feed
- feedbag
- patch
- w3c
---
There's a very special case that I hadn't spotted on <a href="http://axiombox.com/feedbag">Feedbag</a>. Within the different methods that Feedbag uses to discover the feed on a given URL, the very first one is lookup on a table of "known" content types. If the alleged feed is served with any of the following content types, then Feedbag just returns that same URL as it assumes it's the feed:
<pre><code>@content_types = [
'application/x.atom+xml',
'application/atom+xml',
'application/xml',
'text/xml',
'application/rss+xml',
'application/rdf+xml',
]</code></pre>
However, what happens if the feed is not served with any of those but it's a valid feed? Well, Feedbag wouldn't auto-discover the feed itself but would start parsing the HTML, which is time-consuming (and unneeded after all). Because of this, between the content type lookup and the HTML parsing, I've added W3C feed validation using the nice gem <a href="http://feedvalidator.rubyforge.org/">feedvalidator</a>. However, since this would result on an extra dependency, I've left it as optional. If the gem is available, it'll use it, otherwise, it won't and will start parsing the HTML.

You can see the fix patch on <a href="http://github.com/damog/feedbag/commit/227434c850b6421e421a0fc54463c2e5f26cd619">this commit</a>.