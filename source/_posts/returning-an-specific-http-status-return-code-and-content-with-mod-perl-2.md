title: "Returning an specific HTTP status/return code and content with mod_perl 2"
date: 2009/1/6 11:35:12
Tags: apache,mod_perl
---
Making a simple <tt>PerlResponseHandler</tt> that does something like this:
<pre><code>sub handler {
    my($r) = shift;
    $r-&gt;content_type("text/plain");
    $r-&gt;print("You suck.\n");
    return Apache2::Const::HTTP_BAD_REQUEST;
}</code></pre>
...doesn't make what you'd be expecting. This is because mod_perl assumes, since you are specifying content type and something to print, that this is a legit and valid (200-ish) request. This is what you get:
<pre><code>
POST http://myserver/resource --&gt; 200 OK
Connection: close
Date: Mon, 05 Jan 2009 23:02:57 GMT
Content-Type: text/plain; charset=UTF-8
Client-Date: Mon, 05 Jan 2009 23:03:00 GMT
Client-Response-Num: 1
Client-Transfer-Encoding: chunked
[ some headers snipped ]

You suck.
&lt;!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"&gt;
&lt;html&gt;&lt;head&gt;
&lt;title&gt;200 OK&lt;&lt;/title&gt;
&lt;/head&gt;&lt;body&gt;
&lt;h1&gt;OK&lt;/h1&gt;
&lt;p&gt;Your browser sent a request that this server could not understand.&lt;br /&gt;
&lt;/p&gt;
&lt;/body&gt;&lt;/html&gt;
</code></pre>
So, yes, I was expecting to return a 400 Bad Request return with just "You suck" on the response body. mod_perl disagrees, which, kind of sucks if you are trying to make a RESTful service with mod_perl HTTP handlers and filters.

To avoid this behaviour, this is one way to go:
<pre><code>sub handler {
    my($r) = shift;
    $r-&gt;status(400); # or the one you are interested in
    $r-&gt;content_type("text/plain");
    $r-&gt;print("You suck.");
    return Apache2::Const::OK;
}
</code></pre>
You can also take a look at <tt>status_line</tt> that overrides <tt>status</tt>. You can also avoid the content_type method call if you are sloth enough. Now, this is what you get:

<pre><code>
GET https://myserver/resource --> 400 Bad Request
Connection: close
Date: Mon, 05 Jan 2009 23:27:08 GMT
Content-Type: text/plain; charset=UTF-8
Client-Date: Mon, 05 Jan 2009 23:27:10 GMT
Client-Peer: 209.234.249.38:443
Client-Response-Num: 1
[ some headers snipped :) ]

You suck.
</code></pre>

And so, beer awaits.