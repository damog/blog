title: "Large PHP scripts truncated on nginx"
date: 2010/2/3 11:35:14
tags:
- gzip
- javascript
- nginx
- php
- tinymce
- wordpress
---
I spent a couple of <em>hours</em> yesterday trying to debug an issue that made me hit my head against the wall while it lasted.

I run multiple instances of <a href="http://wordpress.org">WordPress</a>, and with it, comes a nice little editor bundled called <a href="http://tinymce.moxiecode.com/">TinyMCE</a>. But on my main WordPress installation (<a href="http://stereonaut.net">this</a> very blog, dear reader, where you are reading this from), TinyMCE wouldn't come up, it wouldn't render properly on the browser, it didn't matter if it was my main browser, Chrome, or Firefox, Safari, cached, uncached, it was just broken. Since I hadn't have the time to go through this issue before, I was using a different editor installed as a plugin. <em>LAME</em>. And coward.

<img class="alignright size-full wp-image-1113" title="nginx" src="http://damog.net/old/stereonaut/2010/02/nginx.gif" alt="" width="121" height="32" />Anyway, I found out that one of the scripts <a href="http://phpxref.ftwr.co.uk/wordpress/nav.html?wp-includes/js/tinymce/wp-tinymce.php.html"><tt>wp-tinymce.php</tt></a> was being returned truncated. Because of that, <a href="http://getfirebug.com/">Firebug</a> would report that some TinyMCE bullshit wasn't defined (JavaScript, oh I'm not very fond of you). Oh, well. I tested calling that script under <a href="http://curl.haxx.se/">curl</a> separately and in fact, it was only returning a fraction of the script, 44K out of the actual 200+K. I also found out that even though my <a href="http://nginx.org/">nginx</a> installation had gzip compression enabled and the PHP had zlib as well, the script wouldn't process the <tt>tinymce.js.gz</tt> but it was returning directly <tt>tinymce.js</tt>. It's alright, I just wanted it to work, no matter if it wouldn't go through gzip, that'd be a matter of some other day.

After a lot of googling I ended up reading <a href="http://www.republicavirtual.com.br/blog/2009/11/03/nginx-truncate-php/">this blog post</a> (in Portuguese), suggesting to make sure the file permissions for both the <tt>client_body_temp</tt> and <tt>fastcgi_temp</tt> directories allowed the user running nginx (<tt>www-data</tt> in my case) to write in them. Apparently large scripts would start writing to disk on them temporarily while processing the shit. Of course, you wouldn't have this issue if you are running an nginx from your operating system package manager (like <a href="http://packages.debian.org/search?keywords=nginx">Debian</a>'s), but this might very well happen when you are running a custom nginx with separate modules and all sorts of crap on top of it:

<code lang="bash">chown www-data:www-data -R /usr/local/nginx/fastcgi_temp/;
chmod -R 777 /usr/local/nginx/fastcgi_temp/;
chown www-data:www-data -R /usr/local/nginx/client_body_temp/;
chmod -R 777 /usr/local/nginx/client_body_temp/;</code>

Obrigado, <a href="http://www.republicavirtual.com.br/blog/">republicavirtual.com.br</a> :-)