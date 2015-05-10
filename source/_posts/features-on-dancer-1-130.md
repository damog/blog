title: "New features on Dancer 1.130"
Date: 2010-02-08 22:36:50
Tags: dancer,perl
---
Last week, or the one before that one, <a href="http://www.sukria.net/">Alexis</a> released <a href="http://dancer.sukria.net">Dancer</a> <a href="http://search.cpan.org/~sukria/Dancer-1.130/lib/Dancer.pm">1.130</a> which represents a big refactoring of the Dancer core code, taking all optional modules away from it: Logging, session and template engines were splited into their respective non-core modules, etc. Additionally, two keyword features were added, header and prefix. I will showcase both in case you haven't heard the good word from them :)

<h3>header</h3>
The <tt>header</tt> keyword allows you to modify or alter the response headers by hand. That was a nice little feature that still hadn't been implemented. With <tt>header</tt> you can do nice little things like this:

<code lang="perl">
get '/set/header' => sub {
  header 'X-Foo' => 'bar';
  "I'm a happy string." . "\n";
}
</code>

And this is what that very same code does:

<code lang="bash">
~ $ curl -i http://0.0.0.0:3000/set/header
HTTP/1.0 200 OK
X-Foo: bar
Content-Type: text/html
X-Powered-By: Perl Dancer 1.130

I'm a happy string.
</code>

Also, <tt>header</tt> has a method synonym, <tt>headers</tt>, and you can use both indistinctly:

<code lang="perl">
get '/some/crap', sub {
  headers 'X-Foo' => 'Bar',
    'X-Bar' => 'Foo';
}</code>

And it will produce the result that you are expecting.

<h3>prefix</h3>

<tt>prefix</tt> is also interesting. It will indicate that the following route handlers' path patters defined for Dancer will be prepended with such prefix. So:

<code lang="perl">
prefix '/user';
get '/home', sub { template 'user_home' };
get '/logout', sub { "bye!" };
</code>

So here we are instructing Dancer two route handlers that happen to be really pointing to "/user/home" and "/user/logout". In order to stop prefixing the route handlers' paths you just do:

<code lang="perl">prefix undef;</code>

And continue with your un-prepended paths.