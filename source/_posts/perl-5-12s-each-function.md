title: "Perl 5.12's each function"
date: 2010/9/23 17:21:46
Tags: perl,perl 5.12,tips
---
With Perl <a href="http://www.nntp.perl.org/group/perl.perl5.porters/2010/04/msg158820.html">5.12</a> released earlier this summer, the <a href="http://perldoc.perl.org/functions/each.html">each</a> function got a nice little addition that I'd like to talk about: It now has the ability to work on arrays, not only key-value pair hashes, but not exactly as you'd expect it (not like Ruby's <a href="http://ruby-doc.org/core/classes/Array.html#M002173">each</a> method).

The traditional way to work with each, using a hash:

<code lang="perl">my %h = (
a => 1,
b => 2,
c => 3,
);

while(my($key, $value) = each %h) {
say "index: $key => value: $value";
}</code>

And the output. Of course, hashes being unordered lists, you won't get the nice little order of an array.

[text]index: c => value: 3
index: a => value: 1
index: b => value: 2
[/text]

Now, when you use an array, each will return the next pair on the list consisting on the index of that element's position and the position itself. Since it returns the next pair, you can iterate through it on the same fashion as when using a hash:

<code lang="perl">my @arr = ('a'..'z');

while(my($index, $value) = each @arr) {
say "index: $index => value: $value";
}</code>

This is particularly useful to access direct named variables, both the index and the element, while looping through an array.

[text]index: 0 => value: a
index: 1 => value: b
index: 2 => value: c
index: 3 => value: d
index: 4 => value: e
index: 5 => value: f
index: 6 => value: g
index: 7 => value: h
index: 8 => value: i
index: 9 => value: j
index: 10 => value: k
index: 11 => value: l
index: 12 => value: m
index: 13 => value: n
index: 14 => value: o
index: 15 => value: p
index: 16 => value: q
index: 17 => value: r
index: 18 => value: s
index: 19 => value: t
index: 20 => value: u
index: 21 => value: v
index: 22 => value: w
index: 23 => value: x
index: 24 => value: y
index: 25 => value: z

[/text]