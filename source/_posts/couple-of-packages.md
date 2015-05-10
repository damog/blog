Title: Couple of packages
Date: 2004-07-11 14:19:44
Tags: 

<p>Finally, <a href="http://ruby-gnome2.sourceforge.jp/#Ruby%2FGtkTrayIcon+0.1.0">libgtk-trayicon-ruby</a> (and -ruby1.8) has entered to Debian queue. This was done thanks to <a href="mailto:paulvtATdebian.org">Paul van Tilburg</a>.

The reason I filled an <a href="http://lists.debian.org/debian-devel/2004/06/msg01494.html">ITP</a> for trayicon library of Ruby was a couple of things:
</p>
<ul>
<li>I wanted to learn Ruby stuff, which seems pretty cool. Like a nice combination of Perl and Python. The best of both are on Ruby.</li>
<li>I was planning to package <a href="http://fraggle.alkali.org/projects/gtray/">GNOME GTray</a>.</li>
</ul>
<p>
The first reason was pretty cool. Although, I am having problems with the second which will bring me to not package it. Why? Two main reasons:
</p>
<ul>
<li>GTray is released on GPL. It uses OpenSSL stuff. It doesn&#8217;t provide an exemption for this incompatibility issues. So, it can&#8217;t be packaged for Debian, at least, not officially.</li>
<li>
<strong>It is illegal</strong> to code external programs of <a href="http://gmail.google.com/">GMail</a>, really.</li>
</ul>
<p>
Reading the Terms of Use document of GMail, I finally get to the conclusion for the last reason:
</p>
<pre>5. Intellectual Property Rights. Google's Intellectual Property Rights. You acknowledge that Google owns
all right, title and interest in and to the Service, including without limitation all intellectual property
rights (the "Google Rights"), and such Google Rights are protected by U.S. and international intellectual
property laws. Accordingly, you agree that you will not copy, reproduce, alter, modify, or create derivative
works from the Service. (!!!!!!!!!!!! -&gt;)You also agree that you will not use any robot, spider, other
automated device, or manual process to monitor or copy any content from the Service. The Google Rights
include rights to (i) the Service developed and provided by Google; and (ii) all software associated with
the Service.  The Google Rights do not include third-party content used as part of Service, including the
content of communications appearing on the Service.</pre>
<p>
Interesting. Tomorrow I will send this issue to debian-legal to see what are their thoughts.

I also have a couple of packages ready: <a href="http://mirjami.net/%7Eville/kipina/">kipina</a> and <a href="http://www.lightlink.com/computer/math/">mathomatic</a>, the last one is a great piece of maths software, studying Computing and Electronic Engineering I find it wide cool. :-)
</p>
<strong>Current Mood:</strong> <img width="15" height="15" src="http://stat.livejournal.com/img/mood/growf/smileys/sad.gif"/> cold
<strong>Current Music:</strong>  - <a href="http://www.degrees.us">www.degrees.us</a>
