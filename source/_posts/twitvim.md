Title: TwitVim: Nice Twitter client
Date: 2009-01-10 17:18:41
Tags: twitter,twitvim
---
I do like <a href="http://twitter.com/">Twitter</a>. For quite some time now I've been trying to find a Twitter client that I'd really like. I've tried, lots of them, <a href="http://www.twhirl.org/">Twhirl</a>, <a href="http://live.gnome.org/DanielMorales/Twitux">Twitux</a>, <a href="http://code.google.com/p/microblog-purple/">microblog-purple</a> (which I started to dislike since I'm not IMing that much anymore and it can become extremely annoying if not blocked), <a href="http://www.tweetdeck.com/">TweetDeck</a>, etc. All of them don't seem to fill my own needs and preferences. Even when Twitter used to support IM, I came up with probably the best solution I've used so far, GTalk on <a href="http://www.bitlbee.org/main.php/news.r.html">Bitlbee</a>, so I could easily use <a href="http://www.irssi.org">Irssi</a> with it. I have also been suggested to use <a href="http://software.complete.org/software/projects/show/twidge">Twidge</a> but direct command-line IO is probably not the best for me. I want to have it a console emulator window, maybe screened in a remote server, running all the time, auto-updating, unobstrusive.

Given this, I started to hack on my own personal client using <a href="http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/">ncurses</a>. Sadly, my lack of deep knowledge of the not-too-intuitive ncurses API made me abort the project. Maybe some day I could retake it. Shame.

Anyway, within the last week, I found and have been using <a href="http://www.vim.org/scripts/script.php?script_id=2204">TwitVim</a>. I like <a href="http://vim.org">Vim</a>: It's my editor of choice for most of my projects. And TwitVim is a really nice project supporting a lot of interesting features:
<p style="text-align: center;"><a href="http://damog.net/old/axiombox/2009/01/twitvim.png"><img class="aligncenter size-medium wp-image-783" title="twitvim" src="http://damog.net/old/axiombox/2009/01/twitvim-300x180.png" alt="twitvim" width="300" height="180" /></a></p>

There you can see how, on a non-obstrusive way, you can have it running. Since it's built on Vim, you can also do some key mappings so that you don't have to type all the commands. And it has all sorts of really cool and interesting features, like if the cursor is on a given line, \r will start a reply, or other binding will start a direct message, etc.

Here's a picture of my own timeline:
<p style="text-align: center;"><a href="http://damog.net/old/axiombox/2009/01/twitvim-user.png"><img class="aligncenter size-medium wp-image-784" title="twitvim-user" src="http://damog.net/old/axiombox/2009/01/twitvim-user-300x180.png" alt="twitvim-user" width="300" height="180" /></a></p>

Once you have installed it, take a look at the extensive and detailed documentation with:
<pre><code>:help TwitVim</code></pre>
However, the only downside is that it doesn't auto-refresh. But you can map a key for quick update:
<pre><code>:nnoremap &lt;F8&gt; :FriendsTwitter&lt;cr&gt;</code></pre>
What Twitter clients do you like and use?