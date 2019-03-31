---
title: "Sync your Twitter followers and friends"
date: 2009-06-10 13:30:29
tag:
- code
- debian
- gems
- ruby
- twitter
---
I have a couple of accounts in Twitter (namely @<a href="http://twitter.com/debian">debian</a> and @<a href="http://twitter.com/planetalinux">planetalinux</a>) that are starting to bring a lot of followers (well, at least some of them). And given that I consider these accounts to be Twitter-polite enough, I like to follow the followers back too; however, this task sometimes gets really hard and it's tiring to go through the followers pages and follow those that I don't follow yet over and over.

So, I spent a few minutes and came up with this simple Ruby script that uses <a href="http://addictedtonew.com/">John Nunemaker</a>'s awesome <a href="http://twitter.rubyforge.org">Twitter gem</a>.

<code lang="ruby">
#!/opt/local/bin/ruby

require "rubygems"
require "twitter"

httpauth = Twitter::HTTPAuth.new(
	ARGV[0] || 'yehyeh',
	ARGV[1] || 'kissm3'
)

base = Twitter::Base.new(httpauth)

i = 0
(base.follower_ids - base.friend_ids).each do |id|
  i += 1
  begin
    base.friendship_create id
  rescue Twitter::General => e
    puts "#{e.class}: #{e.message}"
  end
end
puts "#{i} new friendships."

i = 0
(base.friend_ids - base.follower_ids).each do |id|
  i += 1
  base.friendship_destroy id
end
puts "#{i} destroyed friendships."

puts "#{base.friend_ids.size} friends now."
puts "#{base.follower_ids.size} followers now."
</code>

What this little code does is exactly that, it will start following the followers you don't follow yet, and it will stop following the people that don't follow you back, right? Got it? It's basically synchronizing your friends with your followers. As said, this is particularly helpful when you are maintaining a community account and want to keep up befriending your kind followers :-) Handling the exception <code>Twitter::General</code> on line 18 is only done because the twitter gem raises it even when you are trying to befriend an account to which you have already requested friendship (like pending requests to protected updates accounts) or those of suspended accounts (spammers).