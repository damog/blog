title: "Net::Domain::ES::ccTLD"
Date: 2009-09-01 15:28:23
Tags: cpan,domains,perl,planeta linux,tld,wikipedia
---
As I'm rewriting the core of <a href="http://planetalinux.org">Planeta Linux</a> (you can track progress <a href="http://github.com/axiombox/planetalinux">here</a>), I needed a reliable way to map a country TLD to its Spanish name. I headed to <a href="http://search.cpan.org/">CPAN</a> to see what was already built to do that and found out <a href="http://search.cpan.org/~dmuey/Locales-0.05/lib/Locales/Country.pm">Locales::Country</a> that looked awesome but it didn't work for me, <tt>code2country('ni')</tt> would return <tt>undef</tt> for me, plus the countries that were actually there had the encoding all fubar, so fuck it, drop it.

So I came up with <a href="http://search.cpan.org/dist/Net-Domain-ES-ccTLD/">Net::Domain::ES::ccTLD</a> using the data from the <a href="http://es.wikipedia.org/">Spanish Wikipedia</a> for the <a href="http://es.wikipedia.org/wiki/Dominio_de_nivel_superior_geogr%C3%A1fico">countries TLDs</a>:

[Perl]
use Net::Domain::ES::ccTLD;

my $country = find_name_by_cctld('mx')     # $country is 'México'
  or die "Couldn't find name.";

my $current = find_name_by_cctld('us');    # $current is 'Estados Unidos';
[/Perl]

Why would I reinvent the wheel for this? Because it was easier and faster for me and it's all about practicality, isn't it? Plus the code is super tiny, maybe the smallest module I have in CPAN in terms of actual code.

Feel free to use if you will.