Title: DirectoryIndex and the "perl-script" handler
Date: 2008-12-02 12:12:40
Tags: apache,mod_perl,perl
---
<p><a href="http://www.grep.be/blog/en/computer/play/scriptalias_index.cgi">Wouter Verhelst blogs about combining</a> ScriptAlias (or a way to run CGIs) and DirectoryIndex in Apache.</p>

<p>Recently, developing a TinyURL clone I had a similar (not identical, though) issue.</p>

<p>Basically, I set <tt>SetHandler</tt> to <tt>perl-script</tt> on the <tt>"/"</tt> location, which basically means, everything accessed on a given virtual host, is affected. Because you are changing the handler for the entire location, <tt>DirectoryIndex</tt> will have no effect on it because <tt>mod_dir</tt> is the one dealing with the <tt>DirectoryIndex</tt> function, that is, using the <tt>DIR_MAGIC_TYPE</tt> handler.</p>

<p>To fix this you can use a mod_perl (2, I never really used 1) <tt>Fixup</tt> phase handler:</p>

<p><pre>
&lt;VirtualHost *:80&gt;
	...
	<font color="#444444"># some stuff
	</font>...
	
	<font color="#444444"># PerlSections rule.
	</font>&lt;Perl&gt;
	<font color="#2040a0">$Location</font><font color="4444FF"><strong>{</strong></font><font color="#008000">&quot;/&quot;</font><font color="4444FF"><strong>}</strong></font> = <font color="4444FF"><strong>{</strong></font>
		SetHandler =&gt; <font color="#008000">'perl-script'</font>,
		<font color="#444444"># some stuff
		</font>PerlFixupHandler =&gt; <font color="#008000">'Axiombox::Awbox::Fixup'</font>,
		<font color="#444444"># some other stuff
		</font>DirectoryIndex =&gt; <font color="#008000">'whatever.html'</font>,
	<font color="4444FF"><strong>}</strong></font>;
	&lt;/Perl&gt;

&lt;/VirtualHost&gt;

</pre></p>

<p>If it looks incomplete is because some other information, out of the scope of this sample, like DocumentRoot or other mod_perl directives, are hidden as the "other stuff". My <tt>Fixup.pm</tt> handler looks like this:</p>

<p><pre>
<strong>package</strong> Axiombox::Awbox::Fixup;

<strong>use</strong> strict;
<strong>use</strong> warnings FATAL =&gt; <font color="a52a2a"><strong>qw</strong></font><font color="4444FF"><strong>(</strong></font>all<font color="4444FF"><strong>)</strong></font>;

<strong>use</strong> Apache2::Const -compile =&gt; <font color="a52a2a"><strong>qw</strong></font><font color="4444FF"><strong>(</strong></font>DIR_MAGIC_TYPE OK DECLINED<font color="4444FF"><strong>)</strong></font>;
<strong>use</strong> Apache2::RequestRec;

<strong>sub<font color="ff0000"> handler</font> {</strong>
	<strong>my</strong> <font color="#2040a0">$r</font> = <font color="a52a2a"><strong>shift</strong></font>;

	<strong>if</strong> <font color="4444FF"><strong>(</strong></font><font color="#2040a0">$r</font>-&gt;handler <strong>eq</strong> <font color="#008000">'perl-script'</font> &amp;&amp;
		-d <font color="#2040a0">$r</font>-&gt;filename              &amp;&amp;
		<font color="#2040a0">$r</font>-&gt;is_initial_req<font color="4444FF"><strong>)</strong></font>
	<font color="4444FF"><strong>{</strong></font>
		<font color="#2040a0">$r</font>-&gt;handler<font color="4444FF"><strong>(</strong></font>Apache2::Const::DIR_MAGIC_TYPE<font color="4444FF"><strong>)</strong></font>;

		<strong>return</strong> Apache2::Const::OK;
	<font color="4444FF"><strong>}</strong></font>

	<strong>return</strong> Apache2::Const::DECLINED;
<font color="4444FF"><strong>}</strong></font>

1;

</pre></p>

<p>Which is very straight-forward: If the request is set to <tt>perl-script</tt>, the requested file is a directory and if the current request is the main one, then change the handler and return to the normal flow of phases. Otherwise, decline the <tt>Fixup</tt> phase handler.</p>