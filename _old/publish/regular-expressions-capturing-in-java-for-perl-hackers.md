Title: Regular expressions capturing in Java for Perl hackers
Date: 2009-03-16 15:16:49
Tags: java,perl,regex,scrapping

Capturing is one of the more interesting things you can do with regular expressions, it gives you great power to get sub-strings out of strings with regex power.

I recently came up with the need to do it with Java. Having Perl background, you can understand how awful any other regular expressions implementation can be after been hacked with Perl's, but it's alright, it's cool to learn.

Anyway, it's just simple, you want to capture Perl's <tt>$0</tt>, <tt>$1</tt>, <tt>$2</tt>, etc, in your Java class. Not a problem.

On my example, an HTML string needs to be scrapped. Let's say...
<blockquote><tt>&lt;a href="http://google.com/"&gt;Visit Google today!&lt;/a&gt;</tt></blockquote>
We want to get both the URL and the string between the <tt>&lt;a&gt;</tt> and <tt>&lt;/a&gt;</tt> tags.

<script src="http://gist.github.com/80065.js" type="text/javascript"></script>

So, after all it's very simple. You have your <tt>inputStr</tt> string, and you compile your regex <tt>patternStr</tt> string as a <tt>Pattern</tt> object. Then, create a <tt>Matcher</tt> object crossing both. If we find any matches, we'll make a <tt>for</tt> loop that will iterate on <tt>matcher</tt>'s grouping, printing each group at a time.

I hope some of you Perl hackers, find this information helpful when dealing with Java and need to group/capture your strings.