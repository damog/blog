title: "Quick feed aggregation with Vitacilina"
date: 2009/1/29 21:36:06
Tags: cpan,feed,github,perl,rfeed,vitacilina,yaml
---
<em>Vitacilina, ¡ah, qué buena medicina!</em>

A few months ago. Maybe more than a year, I started hacking on Vitacilina, which was meant to be the replacement for <a href="http://planetplanet.org">Planet</a> on all countries <a href="http://planetalinux.org">Planeta Linux</a> supports. I was doing well, I even hosted the code back then in <a href="http://code.google.com/p/vitacilina">Google Code</a>. Later, I forgot about it, but I'd always been wanting to replace Planet with some homebrew solution for the Planeta Linux community. Anyway, that hasn't happened yet. However, I did start using Vitacilina for my own needs on a local sandbox for my employer and it used to work pretty well. I've been hacking it to fit very specific requirements, though.

Anyway, I thought it was a good moment to release it publicly, just because it was all hidden there. So, I didn't implement the changes I did for my employer (because they were very specific for our products) but I did clean it up and wrote some documentation.

Now, what exactly is <em>Vitacilina</em>? Well, it's a feed aggregator. It's written in Perl (it's a Perl module) and it uses <a href="http://www.yaml.org/">YAML</a> to get its list of feeds and names and <a href="http://template-toolkit.org/">Template Toolkit</a> to format and dump the output, it was efficient for me because it was very easy for me to create dumps:
<pre><code>use Vitacilina;

my $v = Vitacilina-&gt;new(
  config =&gt; "config.yml",
  template =&gt; "template.tt",
  output =&gt; "output.html",
);
$v-&gt;render;
</code></pre>
And that's it. I used to create YAML files on the fly to create new <em>Vitacilina</em> objects and render them according to some data.

The  config file would look something like this:
<pre><code>http://myserver.com/myfeed:
  name: Some Cool Feed
http://feeds.feedburner.com/InfinitePigTheorem:
  name: David Moreno
</code></pre>
And the template file:
<pre><code> [% FOREACH p IN data %]
  &lt;a href="[% p.permalink %]"&gt;[% p.title %]&lt;/a&gt;
   by &lt;a href="[% p.channelUrl %]"&gt;[% p.author %]&lt;/a&gt;

 [% END %]
</code></pre>
In that way, it's very simple, quick and easy to do aggregations. I just love TT, why wouldn't I? :-)

So go grab <a href="http://search.cpan.org/~damog/Vitacilina-0.1/">Vitacilina at CPAN</a>. Also, the Git repo is at <a href="http://github.com/damog/vitacilina">github.com/damog/vitacilina</a>.

However... I started to hack on a similar more ambitious project called <a href="http://github.com/damog/rfeed">rFeed</a>, that it's more of a framework than a simple library, which is why I stopped further Vitacilina development. I'll talk about rFeed later when the time comes.