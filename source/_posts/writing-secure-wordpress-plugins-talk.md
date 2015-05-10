Title: Writing Secure WordPress Plugins talk by Mark Jaquith
Date: 2009-11-24 17:29:18
Tags: ajax,csrf,php,plugins,security,sql injection,wordcamp,wordpress,xss

Continuing my notes and remarks from <a href="http://2009.newyork.wordcamp.org/">WordCamp</a>, I attended <a href="http://2009.newyork.wordcamp.org/2009/11/13/writing-secure-plugins/">Writing Secure Plugins</a>, which was given by <a href="http://markjaquith.com/">Mark Jaquith</a> (@<a href="http://twitter.com/markjaquith">markjaquith</a> on Twitter). I found the talk to be also slightly introductory on security matters but nicely oriented to <a href="http://wordpress.org">WordPress</a> plugins and general PHP Web app development. I believe most of the tips given should be taken into consideration by every PHP coder out there, not just WP people.
<p style="text-align: center;"><a href="http://damog.net/old/stereonaut/2009/11/IMG_30081.jpg"><img class="aligncenter size-medium wp-image-1053" title="IMG_3008" src="http://damog.net/old/stereonaut/2009/11/IMG_30081-300x225.jpg" alt="IMG_3008" width="300" height="225" /></a></p>
<p style="text-align: center;"></p>

The talk was split into the different attacks that are common on Web applications and mainly pointing to functions and actions to be taken. Here are my notes:
<h3>SQL injection</h3>
<ul>
	<li><a href="http://codex.wordpress.org/Data_Validation"><tt>esc_sql()</tt></a>, allows you to escape SQL queries.</li>
	<li><tt>absint()</tt>, allows to convert an ID value to its positive integer value to prevent ID injection.</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/wpdb_Class#UPDATE_rows"><tt>$wpdb-&gt;update()</tt></a>, a WordPress <a href="http://codex.wordpress.org/Plugin_API">API</a> method to update data.</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/wpdb_Class#INSERT_rows"><tt>$wpdb-&gt;insert()</tt></a>, a WordPress API method to insert new data rows.</li>
	<li><a href="http://php.net/compact"><tt>compact()</tt></a>, PHP core function that lets you use variable names as strings.</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/wpdb_Class#Protect_Queries_Against_SQL_Injection_Attacks"><tt>$wpdb-&gt;prepare()</tt></a>, crafts a secure SQL statement with placeholders.</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/wpdb_Class#SELECT_a_Variable"><tt>$wpdb-&gt;get_var()</tt></a>, returns a single variable from WordPress data.</li>
</ul>
<h3>Cross-site scripting (XSS)</h3>
<ul>
	<li>"Everything is suspicious".</li>
	<li><tt><a href="http://wpseek.com/esc_attr_e/">esc_attr_e</a>()</tt>, escapes a translated string to be used as an HTML tag attribute.</li>
	<li><a href="http://wpdevel.wordpress.com/tag/esc_html/"><tt>esc_html()</tt></a>, escapes general HTML.</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/esc_attr"><tt>esc_attr()</tt></a>, escapes a string for tag attribute.</li>
	<li><a href="http://wordpress.org/support/topic/282964"><tt>esc_url()</tt></a>, encodes URL.</li>
	<li><a href="http://wpseek.com/esc_url_raw/"><tt>esc_url_raw()</tt></a>, encodes URL without HTML entities to be encoded.</li>
	<li><a href="http://wpseek.com/esc_js/"><tt>esc_js()</tt></a>, encodes JavaScript code.</li>
</ul>
<h3>Cross-site request forgery (CSRF)</h3>
<ul>
	<li>Understand the difference between authorization and intention.</li>
	<li><a href="http://codex.wordpress.org/WordPress_Nonces">Nonces</a> (token handling).</li>
	<li><a href="http://codex.wordpress.org/Function_Reference/wp_nonce_field"><tt>wp_nonce_field()</tt></a> and then, <a href="http://wpseek.com/check_admin_referer/"><tt>check_admin_referer()</tt></a>.</li>
	<li>current_user_can(), API capability checking.</li>
</ul>
<h3>AJAX CSRF</h3>
<ul>
	<li><a href="http://ocaoimh.ie/89494197/make-your-wordpress-plugin-talk-ajax/"><tt>&amp;_ajax_nonce</tt> = NONCE</a></li>
</ul>
<h3>Privilege escalation</h3>
<h3>Stupid shit!</h3>
<ul>
	<li>Avoid <a href="http://php.net/exec"><tt>exec()</tt></a> at all costs!</li>
	<li>Use blank or hardcoded paths instead of <tt>$_SERVER['REQUEST_URI']</tt> on form submission.</li>
</ul>
<h3>Presentation</h3>
<div style="text-align: center;"><object style="margin: 0px;" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="425" height="355" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"><param name="allowFullScreen" value="true" /><param name="allowScriptAccess" value="always" /><param name="src" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=wordpresssecurity-wordcampny-091114224648-phpapp01&amp;rel=0&amp;stripped_title=writing-secure-plugins-wordcamp-new-york-2009" /><param name="allowfullscreen" value="true" /><embed style="margin: 0px;" type="application/x-shockwave-flash" width="425" height="355" src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=wordpresssecurity-wordcampny-091114224648-phpapp01&amp;rel=0&amp;stripped_title=writing-secure-plugins-wordcamp-new-york-2009" allowscriptaccess="always" allowfullscreen="true"></embed></object></div>