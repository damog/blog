---
title: "New features on Dancer 1.130"
date: 2010-02-08 22:36:50
tag:
- dancer
- perl
---
Last week, or the one before that one, [Alexis](http://www.sukria.net/) released [Dancer](http://perldancer.org/) 1.130 which represents a big refactoring of the Dancer core code, taking all optional modules away from it: Logging, session and template engines were splited into their respective non-core modules, etc. Additionally, two keyword features were added, header and prefix. I will showcase both in case you haven't heard the good word from them :)

**header**
The `header` keyword allows you to modify or alter the response headers by hand. That was a nice little feature that still hadn't been implemented. With `header` you can do nice little things like this:

    get '/set/header' => sub {
        header 'X-Foo' => 'bar';
        "I'm a happy string." . "\n";
    }

And this is what that very same code does:

    ~ $ curl -i http://0.0.0.0:3000/set/header
    HTTP/1.0 200 OK
    X-Foo: bar
    Content-Type: text/html
    X-Powered-By: Perl Dancer 1.130

    I'm a happy string.

Also, `header` has a method synonym, `headers`, and you can use both indistinctly:

    get '/some/crap', sub {
        headers 'X-Foo' => 'Bar',
            'X-Bar' => 'Foo';
    }

And it will produce the result that you are expecting.

**prefix**

`prefix` is also interesting. It will indicate that the following route handlers' path patters defined for Dancer will be prepended with such prefix. So:

    prefix '/user';
    get '/home', sub { template 'user_home' };
    get '/logout', sub { "bye!" };

So here we are instructing Dancer two route handlers that happen to be really pointing to `/user/home` and `/user/logout`. In order to stop prefixing the route handlers' paths you just do:

    prefix undef;

And continue with your un-prepended paths.
