title: "Caching and optimization for WordPress talk"
date: 2009/12/21 14:18:48
tags:
- caching
- optimization
- wcnyc
- wordpress
---
Continuing with my [WordCamp NYC](http://2009.newyork.wordcamp.org/) talks review, I'd like to point out the notes I took attending the talk *Caching and Optimization for WordPress*, by [Jeremy Clarke](http://simianuprising.com/).

I believe this was a great topic to be covered for people who actively maintain [WordPress](http://wordpress.org/) installations and have to deal with upgrades, stability and reliability. However, I also think Jeremy took a much more basic approach for this topic the way it shouldn't have to be. He would describe all the tools that he was showcasing from the most basic parts of it, like what's a terminal or why you should use it, to an audience attending the advanced development track.

Anyway, here are my notes:

- Expect a lot of traffic for your websites.
- First point of review, [slow database queries](http://wordpress.org/support/topic/300880).
- [Caching](http://en.wikipedia.org/wiki/Web_cache).
    - Serving already fetched data.
- [WP Super Cache](http://wordpress.org/extend/plugins/wp-super-cache/) (mandatory cache plugin).
- [WP Tuner](http://wordpress.org/extend/plugins/wptuner/) (resources information).
- [YSlow, Yahoo's Firebug plugin](/blog/2009/11/16/yahoo-yslow-for-firebug).
- If necessary, use [Gravatar](http://gravatar.com).
- [Memcached for WordPress](http://mohanjith.net/blog/2008/10/using-memcached-with-wordpress-object-cache.html).
- "CLI: The DOS-style of using a computer'. What a quote.
- [htop](http://htop.sourceforge.net/), a much more intuitive top.
- [apachetop](http://www.webta.org/projects/apachetop/), an Apache processes visualizer.
- [MySQL Tuning Primer Script](http://www.day32.com/MySQL/)
- Use either [APC](http://pecl.php.net/package/APC), [memcached](http://php.net/manual/en/book.memcache.php) or [XCache](http://xcache.lighttpd.net/).
- [Monit](http://mmonit.com/monit/), triggering commands.

After the talk I prompted him to whether he would consider also moving away from [Apache](http://httpd.apache.org/) and trying much faster alternatives like [FastCGI PHP](https://www.nginx.com/resources/wiki/start/topics/examples/phpfcgi/) on [nginx](http://nginx.org/) or [Cherokee](http://www.cherokee-project.com/). He mentioned that he had considered it, but he preferred to stick with the most conventional and commonly used software for his installations. That's his opinion, of course. On mine, based on my own experience, dropping Apache is usually one of the best ways to workaround most of the issues around a slow WordPress.

Now thanks to [WordPress.tv](http://wordpress.tv/), we have a video of the talk that Jeremy delivered on a previous event:

<p style="text-align: center; "><embed src="http://v.wordpress.com/wp-content/plugins/video/flvplayer.swf?ver=1.11" type="application/x-shockwave-flash" width="400" height="300" allowscriptaccess="always" allowfullscreen="true" flashvars="guid=P1pO85U7&amp;width=400&amp;height=300" title=""></embed></p>
