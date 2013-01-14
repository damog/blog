Title: Google's first tweet
Date: 2009-02-26 13:02:34
Tags: binary,google,map,octal,perl,twitter

<a href="http://google.com">Google</a> created an official <a href="http://twitter.com">Twitter</a> <a href="http://twitter.com/google">account</a>. Its <a href="http://twitter.com/google/status/1251523388">first tweet</a> was something odd:
<blockquote><span class="status-body"><span class="entry-content">I'm 01100110 01100101 01100101 01101100 01101001 01101110 01100111 00100000 01101100 01110101 01100011 01101011 01111001 00001010</span></span></blockquote>
I had <a href="http://log.damog.net/2007/10/tip-perl-del-dia-chr-y-oct-en-un-loop-map/">previously written</a> (in Spanish, for <a href="http://log.damog.net/index.php?s=columna+de+perl">La Columna de Perl</a>), how to quickly decode this "way" of binary writing with Perl's <tt>chr</tt> and <tt>oct</tt>. So, to find out what was Google really tweeting, run:
<blockquote>
<code>perl -e 'map { print chr oct "0b".$_; } split /\s/, "01100110 01100101 01100101 01101100 01101001 01101110 01100111 00100000 01101100 01110101 01100011 01101011 01111001 00001010";'</code>
</blockquote>
So, what's really happening with this snippet? Well, the zeroes-ones string is being passed to the <tt>split</tt> function that explodes the string with a whitespace delimiter and passes that exploded string, a list, to <tt>map</tt>. <tt>map</tt> takes each one of the elements, the 8-character substring, one by one and preppends "<tt>0b</tt>" so that <tt>oct</tt> can understand it as an octal string and returns the value for that character. Then, that value is passed to <tt>chr</tt> that takes the numerical representation of a given character and returns that character. Then, it's just passed to print that, surprise, prints out that value.

How do you do it in your language of choice?