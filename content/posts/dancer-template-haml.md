---
title: "Dancer::Template::Haml now available"
date: 2010-02-11 16:43:53
tag:
- dancer
- haml
- perl
- ruby
---
I put together a quick template engine for [Dancer](http://perldancer.org/) using [Haml](http://haml-lang.com) via [Text::Haml](http://search.cpan.org/dist/Text-Haml/). You know Haml, right?

Now you can do neat shit like this:

     set template => 'haml';

     get '/bazinga', sub {
            template 'bazinga' => {
                title => 'Bazinga!',
                content => 'Bazinga?',
            };
     };

Using:

    !!!
    %html{ : xmlns => "http://www.w3.org/1999/xhtml", :lang => "en", "xml:lang" => "en"}
      %head
        %title= title
      %body
        #content
          %strong= content

The dope thing about `Text::Haml` is that things like the Ruby interpolation will keep working.

Hurray! [Go get it now](http://search.cpan.org/dist/Dancer-Template-Haml/).
