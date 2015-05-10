Title: Securing WordPress talk
Date: 2009-11-20 13:20:25
Tags: security,wordcamp,wordpress
---
Here I start a series of posts with my comments, notes and remarks on the talks that I attended at last weekend's <a href="http://2009.newyork.wordcamp.org/">WordCamp</a> in NYC.

<img class="alignright size-full wp-image-1034" title="Screen shot 2009-11-20 at 1.19.12 PM" src="http://damog.net/old/stereonaut/2009/11/Screen-shot-2009-11-20-at-1.19.12-PM.png" alt="Screen shot 2009-11-20 at 1.19.12 PM" width="165" height="156" />The first talk I attended was <strong>Securing WordPress</strong>, <a href="http://www.strangework.com/">by Brad Williams</a> (@<a href="http://twitter.com/williamsba">williamsba</a> on Twitter). First off, this talk wasn't too technical since it was focused to beginning developers whose background wouldn't be completely into systems administration, it was intended to a broader audience, which is exactly why I liked it so much and started taking notes. You need some mild level of expertise on <a href="http://wordpress.org">WordPress</a> for most of what Brad mentioned but you don't have to be an expert.
<p style="text-align: center;"><img class="aligncenter size-full wp-image-1043" title="IMG_3006" src="http://damog.net/old/stereonaut/2009/11/IMG_3006.JPG" alt="IMG_3006" width="403" height="302" /></p>

So, most of the notes I took were taken directly from the slides (that you can browse below in the Slideshare widget), but I also add some homebrewed comments myself:
<h3>Don't use the admin account: Change it</h3>
Hackers will most likely target to the most privileged account on a WordPress that by default goes by the name of "admin" and you don't seem to be able to change it easily from the administration panel. Go ahead and do it on the MySQL shell yourself:

[sql]UPDATE wp_users SET user_login="notadmin" WHERE user_login="admin";[/sql]
<h3>Change your files' permissions</h3>
This is what Brad called "<em>The Great Permission Debate</em>". You are basically fine if you leave all files under 0644 and directories under 0755.

<code lang="bash">$ find wordpress_root/ -type f -exec chmod 644 {} \;
$ find wordpress_root/ -type d -exec chmod 755 {} \;</code>
<h3>Take wp-config.php out of WordPress</h3>
Starting in <a href="http://codex.wordpress.org/Version_2.6">2.6</a>, WordPress will also look for the wp-config.php configuration file on the parent directory of your WordPress directory, which depending on your setup, might be not reachable to your web server's public files.
<h3>Move plugins and uploads directory out of WordPress</h3>
Also since 2.6, WordPress can be configured so that you don't have your plugins and uploads directory (where you upload files from the administration panel) to point somewhere else. You can do it by setting the constants WP_CONTENT_DIR, WP_CONTENT_URL, WP_PLUGIN_DIR and WP_PLUGIN_URL:

[php]define('WP_CONTENT_DIR', $_SERVER['DOCUMENT_ROOT'] . '/your/blog/contents');
define('WP_CONTENT_URL', "http://myblog.com/contents");
...[/php]
<h3>Remove the WordPress version from the META head</h3>
WordPress apparently uses the generator META tag to scan for WordPress installations and create statistics of usage. That also enables possible attackers to discover what version of WordPress you are using, and if you are using an old vulnerable one, you might get hit. You can use the WordPress function, <a href="http://codex.wordpress.org/Plugin_API/Action_Reference/wp_head">wp_head()</a> instead.
<h3>Stay current on updates</h3>
Of course, always focus on getting the latest <a href="http://wordpress.org/download/">updates</a> installed.
<h3>Secure passwords</h3>
Don't use "password" or "a" or "123" as a password for your installations. I recommend generating your password with a little tool called <a href="http://pwgen.sourceforge.net/">pwgen</a>.
<h3>Secret keys</h3>
You can add some salt to your password by setting values for a few secret key constants. This will make a better encryption on the information stored on the user's cookies. Codex puts this as an example:

[php]
define('AUTH_KEY', ':dr+%/5V4sAUG-gg%aS*v;&amp;amp;amp;amp;xGhd%{YKC^Z7KKGh j&amp;amp;gt;k[.Nf$y7iGKdJ3c*[Kr5Bg');
define('SECURE_AUTH_KEY', 'TufWOuA _.t&amp;amp;gt;#+hA?^|3RfGTm&amp;amp;gt;@*+S=8\"\'+\"}]&amp;amp;lt;m#+}V)p:Qi?jXLq,&amp;amp;lt;h\\`39m_(');
define('LOGGED_IN_KEY', 'S~AACm4h1;T^\"qW3_8Zv!Ji=y|)~5i63JI |Al[(&amp;amp;lt;YS&amp;amp;lt;2V^$T])=8Xh2a:b:}U_E');
define('NONCE_KEY', 'k1+EOc-&amp;amp;amp;amp;w?hG8j84&amp;amp;gt;6L9v\"6C89NH?ui{*3\\(t09mumL/fFP_!K$JCEkLuy ={x{0');
[/php]

For more information on each of these secret keys, go to read their <a href="http://codex.wordpress.org/Editing_wp-config.php#Security_Keys">documentation</a>.
<h3>Change the WordPress tables prefix</h3>
The database for a WordPress installation uses a prefix on each of the tables it uses, by default "wp_". You can change it to be a custom value.
<h3>Make sure you have HTTPS and force login and admin access through it</h3>
If it's possible, enable SSL on your host and configure WordPress to pass all login information and <a href="http://codex.wordpress.org/Administration_Over_SSL">administration access through it</a>. You can do it by setting the constants FORCE_SSL_LOGIN and FORCE_SSL_ADMIN to true.
<h3>IP lockdown</h3>
If you are using the Apache webserver, you can configure it so that <a href="http://httpd.apache.org/docs/2.0/howto/htaccess.html">it only allows  access</a> to /wp-admin from a given IP (work or home only). You can do just about the same with any other webserver available (namely, <a href="http://www.alrond.com/en/2007/apr/12/restriction-access-with-nginx/">nginx</a>).
<h3>Security Plugins</h3>
Some of the following plugins will make your life easier. I recommend taking a look at them, they are worthwhile!
<h4><a href="http://wordpress.org/extend/plugins/wp-security-scan/">WP Security Scan</a></h4>
Scans your WordPress installation for security vulnerabilities and suggests corrective actions.
<p style="text-align: center;"><img class="aligncenter size-full wp-image-1032" title="screenshot-1" src="http://damog.net/old/stereonaut/2009/11/screenshot-1.jpg" alt="screenshot-1" width="602" height="286" /></p>

<h4><a href="http://ocaoimh.ie/exploit-scanner/">WordPress Exploit Scanner</a></h4>
This plugin searches the files and database of your website for signs of suspicious activity.
<p style="text-align: center;"><img class="aligncenter size-full wp-image-1033" title="exploit-scanner" src="http://damog.net/old/stereonaut/2009/11/exploit-scanner.gif" alt="exploit-scanner" width="360" height="258" /></p>

<h4><a href="http://mattwalters.net/projects/wordpress-file-monitor/">WordPress File Monitor</a></h4>
Monitors your WordPress installation for added/deleted/changed files. When a change is detected an email alert can be sent to a specified address.
<h4><a href="http://wordpress.org/extend/plugins/login-lockdown/">Login Lockdown</a></h4>
Login LockDown records the IP address and timestamp of every failed login attempt. If more than a  certain number of attempts are detected within a short period of time from the same IP range, then the login function is disabled for all requests from that range.
<h3>Finally</h3>
Some of the actions here are just preventive or simple security by obscurity. Truth is, you will never be 100% secure and you have to be certain that you understand that.
<h2>Presentation</h2>
This is Brad's presentation:
<div><object style="margin:0px" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="425" height="355" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"><param name="allowFullScreen" value="true" /><param name="allowScriptAccess" value="always" /><param name="src" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=wordpress-security-updated-091114122947-phpapp02&amp;rel=0&amp;stripped_title=wordpress-security-updated" /><param name="allowfullscreen" value="true" /><embed style="margin:0px" type="application/x-shockwave-flash" width="425" height="355" src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=wordpress-security-updated-091114122947-phpapp02&amp;rel=0&amp;stripped_title=wordpress-security-updated" allowscriptaccess="always" allowfullscreen="true"></embed></object></div>
