Title: RVM + Rake tasks on Cron jobs
Date: 2011-08-02 10:57:38
Tags: cron,crontab,rake,ruby,rubygems,rvm
---
<a href="https://rvm.beginrescueend.com/">RVM</a> hates my guts. And it doesn't matter, because I hate RVM back even more. Since I was technologically raised by aging wolfs, I have strong reasons to believe that you just shouldn't have mixed versions of software on your production systems, specially, if a lot of things are poorly tested, like <a href="http://rubygems.org/">most of Ruby libraries</a>, aren't backward compatible. I was raised on a world where everything worked greatly because the good folks at projects like <a href="http://www.debian.org/">Debian</a> or <a href="http://search.cpan.org/">Perl</a> have some of the greatest QA processes of all time, hands down. So, when someone introduces a thing like RVM which not only promotes having hundreds of different versions of the same software, both on development, testing and production environments, but also encourages poor quality looking back and looking forward, there isn't anything else but to lose faith in humanity.

But enough for ranting.

I had to deliver this side project that works with the <a href="http://dev.twitter.com/">Twitter API</a> and the only requirement pretty much was that it had to be both run from the shell but also loaded as a class within a Ruby script. And so I did everything locally with my great local installation of Ruby 1.8.7. When it came the time to load on the testing/production server I found myself on a situation where pathetic RVM was installed. After spending hours trying to accommodate my changes to run properly with Ruby 1.9.2, I set up a cron job using crontab to run my shit every now and then. And the shit wasn't even running properly. Basically, my crontab line looked something like this:

<code lang="bash">
*/30 * * * * cd /home/david/myproject &amp;&amp; rake awesome_task
</code>

And that was failing, crontab was returning some crazy shit like "Ruby and/or RubyGems cannot find the rake gem". Seriously? Then I thought, well, maybe my environment needs to be loaded and whatever, so I made a bash script with something like this:

<code lang="bash">
#!/bin/bash
cd /home/david/myproject
/full/path/to/rvm/bin/rake -f Rakefile awesome_task
</code>

And that was still failing with the same error. So after trying to find out how cron jobs and crontab load Bash source files, I took a look at <a href="http://wiki.debian.org/DotFiles">how Debian starts its shell</a> upon login. And while that didn't tell me that much that I didn't know, I went to look at the system-wide /etc/profile and found a gem, a wonderful directory /etc/profile.d/ where a single shitty file was sitting, smiling back at me, like waiting for me to find it out and swear on all problems in life: rvm.sh. /etc/profile is not being loaded when I just run /bin/bash by my crappy script, only when I log in, I should've known this. Doesn't RVM solve the issue of having system-wide installations so the user doesn't have to deal with, you know, anything outside of his own /home ?

So I had to go ahead and do:

<code lang="bash">
#!/bin/bash
source /etc/profile
cd /home/david/myproject
/full/path/to/rvm/bin/rake -f Rakefile awesome_task
</code>

And hours later I was able to continue with work. Maybe this will help some poor bastard like myself on similar situation on the future.

Of course one can argue that I could've installed my own RVM and its Ruby versions, but why, oh why, if it was, apparently, already there. Why would I have to fiddle with the Ruby installations if all I want is get my shit done and head to City Bakery where I can spend that money I just earned on chocolate cookies? My work is pretty simple to run with pretty much any ancient version of Ruby, nothing fancy (unless you call MongoMapper fancy). RVM is a great project that doesn't solve an issue, but just hides some really fucked up shit on the Ruby community.