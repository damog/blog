Title: Dancer::Template::Haml now available
Date: 2010-02-11 16:43:53
Tags: dancer,haml,perl,ruby

I put together a quick template engine for <a href="http://dancer.sukria.net/">Dancer</a> using <a href="http://haml-lang.com">Haml</a> via <a href="http://search.cpan.org/dist/Text-Haml/">Text::Haml</a>. You know Haml, right?

Now you can do neat shit like this:

<code lang="perl">
 set template => 'haml';
 
 get '/bazinga', sub {
        template 'bazinga' => {
                title => 'Bazinga!',
                content => 'Bazinga?',
        };
 };
</code>

Using:

<code lang="ruby">
 !!!
 %html{ : xmlns => "http://www.w3.org/1999/xhtml", :lang => "en", "xml:lang" => "en"}
   %head
     %title= title
   %body
     #content
       %strong= content
</code>

The dope thing about Text::Haml is that things like the Ruby interpolation will keep working.

Hurray! <a href="http://search.cpan.org/dist/Dancer-Template-Haml/">Go get it now</a>.