---
title: "Net::Domain::ES::ccTLD"
date: 2009-09-01 15:28:23
tag:
- cpan
- domains
- perl
- planeta linux
- tld
- wikipedia
---
As I'm rewriting the core of [Planeta Linux](http://planetalinux.org) (you can track progress [here](http://github.com/axiombox/planetalinux)), I needed a reliable way to map a country TLD to its Spanish name. I headed to *meta*[CPAN](https://metacpan.org/) to see what was already built to do that and found out [Locales::Country](https://metacpan.org/pod/release/DYACOB/Locales-0.04/lib/Locales/Country.pm) that looked awesome but didn't work for me, `code2country('ni')` would return <tt>undef</tt> for me, plus the countries that were actually there had the encoding all *fubar*, so fuck it, drop it.

So I came up with [Net::Domain::ES::ccTLD](http://search.cpan.org/dist/Net-Domain-ES-ccTLD/) using the data from the [Spanish Wikipedia](http://es.wikipedia.org/) for the [countries TLDs](http://es.wikipedia.org/wiki/Dominio_de_nivel_superior_geogr%C3%A1fico):

    use Net::Domain::ES::ccTLD;

    my $country = find_name_by_cctld('mx')     # $country is 'México'
      or die "Couldn't find name.";

    my $current = find_name_by_cctld('us');    # $current is 'Estados Unidos';

Why would I reinvent the wheel for this? Because it was easier and faster for me and it's all about practicality, isn't it? Plus the code is super tiny, maybe the smallest module I have in CPAN in terms of actual code.

Feel free to use if you will.
