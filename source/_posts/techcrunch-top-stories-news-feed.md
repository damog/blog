title: "TechCrunch top-stories news feed"
Date: 2010-03-14 18:54:33
Tags: feed,hack,techcrunch,top stories
---
Being surrounded by the Web 2.0, I have to keep myself informed. <a href="http://techcrunch.com">TechCrunch</a> is the most natural source of information. However, they write a lot of news stories every single day. A lot. Enough to make me feel stressed just to have so many shit to read on my feed reader.

Well, since I still wanted to read the top stories, but they don't provide such a feed, like <a href="http://lifehacker.com/">Lifehacker</a> (<a href="http://lifehacker.com/tag/top/index.xml">kind of</a>) does, I hacked a feed:
<p style="text-align: center;"><a href="http://topstories.axiombox.com/techcrunch.rss">http://topstories.axiombox.com/techcrunch.rss</a></p>
This will grab the usual TechCrunch feed but it will test every single entry against the retweets registered on TweetMeme for each post. If the number of RTs is at least 500, the story gets pushed onto this feed. This filters out a lot of their stuff and leaves a manageable storyline of about 3 to 6 stories a day, coming from a 20 or 30+ stories a day on the regular feed.

Feel free to grab the feed and use it. Maybe in the future I'll add a configurable threshold parameter for the number of RTs for posts to be filtered. In the meantime, this what I got.