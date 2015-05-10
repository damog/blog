Title: Caching and optimization for WordPress talk
Date: 2009-12-21 14:18:48
Tags: caching,optimization,wcnyc,wordpress
---
<p>Continuing with my <a href="http://2009.newyork.wordcamp.org/">WordCamp NYC</a> talks review, I'd like to point out the notes I took attending the talk <em>Caching and Optimization for WordPress</em>, by <a href="http://simianuprising.com/">Jeremy Clarke</a>.</p>
<p>I believe this was a great topic to be covered for people who actively maintain <a href="http://wordpress.org/">WordPress</a> installations and have to deal with upgrades, stability and reliability. However, I also think Jeremy took a much more basic approach for this topic the way it shouldn't have to be. He would describe all the tools that he was showcasing from the most basic parts of it, like what's a terminal or why you should use it, to an audience attending the advanced development track.</p>
<p>Anyway, here are my notes:</p>
<ul>
    <li>Expect a lot of traffic for your websites.</li>
    <li>First point of review, <a href="http://wordpress.org/support/topic/300880">slow database queries</a>.</li>
    <li><a href="http://en.wikipedia.org/wiki/Web_cache">Caching</a>.
    <ul>
        <li>Serving already fetched data.</li>
    </ul>
    </li>
    <li><a href="http://wordpress.org/extend/plugins/wp-super-cache/">WP Super Cache</a> (mandatory cache plugin).</li>
    <li><a href="http://wordpress.org/extend/plugins/wptuner/">WP Tuner</a> (resources information).</li>
    <li><a href="http://stereonaut.net/yahoo-yslow-for-firebug/">YSlow, Yahoo's Firebug plugin</a>.</li>
    <li>If necessary, use <a href="http://gravatar.com">Gravatar</a>.</li>
    <li><a href="http://mohanjith.net/blog/2008/10/using-memcached-with-wordpress-object-cache.html">Memcached for WordPress</a>.</li>
    <li>&quot;CLI: The DOS-style of using a computer&quot;. What a quote.</li>
    <li><a href="http://htop.sourceforge.net/">htop</a>, a much more intuitive top.</li>
    <li><a href="http://www.webta.org/projects/apachetop/">apachetop</a>, an Apache processes visualizer.</li>
    <li><a href="http://www.day32.com/MySQL/">MySQL Tuning Primer Script</a>.</li>
    <li>Use either <a href="http://pecl.php.net/package/APC">APC</a>, <a href="http://php.net/manual/en/book.memcache.php">memcached</a> or <a href="http://xcache.lighttpd.net/">XCache</a>.</li>
    <li><a href="http://mmonit.com/monit/">Monit</a>, triggering commands.</li>
</ul>
<p>After the talk I prompted him to whether he would consider also moving away from <a href="http://httpd.apache.org/">Apache</a> and trying much faster alternatives like <a href="http://www.fastcgi.com/drupal/node/5?q=node/10">FastCGI PHP</a> on <a href="http://nginx.org/">nginx</a> or <a href="http://www.cherokee-project.com/">Cherokee</a>. He mentioned that he had considered it, but he preferred to stick with the most conventional and commonly used software for his installations. That's his opinion, of course. On mine, based on my own experience, dropping Apache is usually one of the best ways to workaround most of the issues around a slow WordPress.</p>
<p>Now thanks to <a href="http://wordpress.tv/">WordPress.tv</a>, we have a video of the talk that Jeremy delivered on a previos event:</p>
<p style="text-align: center; "><embed src="http://v.wordpress.com/wp-content/plugins/video/flvplayer.swf?ver=1.11" type="application/x-shockwave-flash" width="400" height="300" allowscriptaccess="always" allowfullscreen="true" flashvars="guid=P1pO85U7&amp;width=400&amp;height=300" title=""></embed></p>
<p style="text-align: left; ">And his slides:</p>
<p style="text-align: center; "><object style="margin:0px" width="425" height="355">
<param name="movie" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=jeremyclarke-wcmtl-optimization-090711143857-phpapp02&amp;rel=0&amp;stripped_title=caching-and-optimization-for-wordpress" />
<param name="allowFullScreen" value="true" />
<param name="allowScriptAccess" value="always" /><embed src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=jeremyclarke-wcmtl-optimization-090711143857-phpapp02&amp;rel=0&amp;stripped_title=caching-and-optimization-for-wordpress" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="355"></embed></object></p>