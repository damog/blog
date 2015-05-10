title: "How to make a simple valid RSS feed"
date: 2005/3/28 04:26:44
Tags: 
---
<p>I finally found some time to update my RSS feed creator script and port it into Ruby. I have to say, <a href="http://packages.debian.org/mambo">Mambo</a> is a really cool cms, but its feed creator sucks. So if you are wanting to generate your own RSS feed you can do it with this little Ruby script (yes, I know you can also do it with Perl, but Ruby is funnier :-):</p>
<pre>#!/usr/bin/env ruby

# You'll need libdbd-mysql-ruby (in MySQL's case) and libruby
require "dbi"
require "rss/maker"

# Similar to Perl's DBI
dbh = DBI.connect("dbi:Mysql:TABLE:HOSTNAME", 'USER', 'PASSWD')

# This is the case for Mambo, it would depend on your cms:
sth=dbh.prepare('select id, title, introtext, created from content where \
catid=69 order by `created` desc limit 10')
sth.execute

rss = RSS::Maker.make("2.0") do |maker|
maker.channel.title = "YOUR TITLE"
maker.channel.description = "I AM A DESCRIPTION"
maker.channel.link = "YOUR WEBSITE"
maker.channel.generator = "libruby1.8, libdbi-ruby1.8 and mambo, \
all debian packages"

sth.fetch do |row|
item = maker.items.new_item
item.link = "http://damog.net/index.php?option=com_content&amp;task=view&amp;id=", row[0]
item.title = row[1]
item.description = row[2]
item.date = Time.parse("%s", row[3])
item.author = "David Moreno Garza &lt;damog@damog.net&gt;"
end
sth.finish

end

puts rss
dbh.disconnect if dbh
</pre>
<p>Nice, isn&#8217;t it?</p>
<br/><br/>
