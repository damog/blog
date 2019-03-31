---
title: "Quick feed aggregation with Vitacilina"
date: 2009-01-29 21:36:06
tag:
- cpan
- feed
- github
- perl
- rfeed
- vitacilina
- yaml
---
*Vitacilina, ¡ah, qué buena medicina!*

A few months ago. Maybe more than a year, I started hacking on Vitacilina, which was meant to be the replacement for [Planet](http://planetplanet.org) on all countries [Planeta Linux](http://planetalinux.org) supports. I was doing well, I even hosted the code back then in [Google Code](http://code.google.com/p/vitacilina). Later, I forgot about it, but I'd always been wanting to replace Planet with some homebrew solution for the Planeta Linux community. Anyway, that hasn't happened yet. However, I did start using Vitacilina for my own needs on a local sandbox for my employer and it used to work pretty well. I've been hacking it to fit very specific requirements, though.

Anyway, I thought it was a good moment to release it publicly, just because it was all hidden there. So, I didn't implement the changes I did for my employer (because they were very specific for our products) but I did clean it up and wrote some documentation.

Now, what exactly is *Vitacilina*? Well, it's a feed aggregator. It's written in Perl (it's a Perl module) and it uses [YAML](http://www.yaml.org/) to get its list of feeds and names and [Template Toolkit](http://template-toolkit.org/) to format and dump the output, it was efficient for me because it was very easy for me to create dumps:

    use Vitacilina;

    my $v = Vitacilina->new(
      config => "config.yml",
      template => "template.tt",
      output => "output.html",
    );
    $v->render;

And that's it. I used to create YAML files on the fly to create new *Vitacilina* objects and render them according to some data.

The  config file would look something like this:

    http://myserver.com/myfeed:
      name: Some Cool Feed
    http://feeds.feedburner.com/InfinitePigTheorem:
      name: David Moreno

And the template file:

    [% FOREACH p IN data %]
      <a href="[% p.permalink %]">[% p.title %]</a>
       by <a href="[% p.channelUrl %]">[% p.author %]</a>
    [% END %]

In that way, it's very simple, quick and easy to do aggregations. I just love TT, why wouldn't I? :-)

So go grab [Vitacilina at CPAN](https://metacpan.org/pod/Vitacilina). Also, the Git repo is at [github.com/damog/vitacilina](http://github.com/damog/vitacilina).

However... I started to hack on a similar more ambitious project called [rFeed](http://github.com/damog/rfeed), that it's more of a framework than a simple library, which is why I stopped further Vitacilina development. I'll talk about rFeed later when the time comes.
