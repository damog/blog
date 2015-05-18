title: "Configuración dinámica en Apache"
date: 2008/11/15 14:20:09
tags:
- la columna de perl
- mod_perl
- perl
- planeta linux
---
Una de las cosas más bonitas que puedes hacer gracias a <a href="http://perl.apache.org/"><tt>mod_perl</tt></a>, son las <a href="http://perl.apache.org/docs/2.0/api/Apache2/PerlSections.html"><code>PerlSections</code></a>.

Básicamente con éstas, lo que puedes hacer es definir dinámicamente directivas de configuración de Apache y hacer cosas bien interesantes. Por ejemplo, recientemente, para <a href="http://planetalinux.org">Planeta Linux</a> quería tener una sola configuración de Apache para los virtual hosts que son repetitivos dada cada instancia (mx.planetalinux.org, ve.planetalinux.org, gt.planetalinux.org, etc). Precisamente lo que quiero evitar es tener que poner una interminable lista de <code>VirtualHost</code>'s, así que lo puedo hacer con secciones en Perl (que son denotadas en cualquier archivo de configuración en Apache con <code>&lt;Perl&gt;</code> y <code>&lt;/Perl&gt;</code>):

<code>&lt;Perl&gt;</code>
<pre>	<strong>my</strong> <span style="color: #2040a0;">$names</span> = <span style="color: #4444ff;"><strong>{</strong></span>
		cl =&gt; <span style="color: #008000;">'PlanetaLinuxChile'</span>,
		co =&gt; <span style="color: #008000;">'PlanetaLinuxColombia'</span>,
		cr =&gt; <span style="color: #008000;">'PlanetaLinuxCostaRica'</span>,
		ec =&gt; <span style="color: #008000;">'PlanetaLinuxEcuador'</span>,
		sv =&gt; <span style="color: #008000;">'PlanetaLinuxElSalvador'</span>,
		es =&gt; <span style="color: #008000;">'PlanetaLinuxEspana'</span>,
		gt =&gt; <span style="color: #008000;">'PlanetaLinuxGuatemala'</span>,
		mx =&gt; <span style="color: #008000;">'PlanetaLinuxMexico'</span>,
		ni =&gt; <span style="color: #008000;">'PlanetaLinuxNicaragua'</span>,
		pa =&gt; <span style="color: #008000;">'PlanetaLinuxPanama'</span>,
		pe =&gt; <span style="color: #008000;">'PlanetaLinuxPeru'</span>,
		ve =&gt; <span style="color: #008000;">'PlanetaLinuxVenezuela'</span>,
		debian =&gt; <span style="color: #008000;">'PlanetaDebian'</span>,
	<span style="color: #4444ff;"><strong>}</strong></span>;</pre>

Defino una referencia a hash en <code>$names</code> que lista contra los "TLDs" de cada instancia y con su nombre largo.

<pre>	<strong>my</strong> <span style="color: #2040a0;">$instancias</span> = <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #a52a2a;"><strong>keys</strong></span> <span style="color: #2040a0;">%{$names}</span><span style="color: #4444ff;"><strong>]</strong></span>;</pre>

Para facilitar trabajar con las llaves, creo una referencia a un arreglo que contiene exclusivamente las llaves del hash que previamente tenía definido.

<pre>	<span style="color: #2040a0;">$VirtualHost</span><span style="color: #4444ff;"><strong>{</strong></span><span style="color: #008000;">"*:80"</span><span style="color: #4444ff;"><strong>}</strong></span> = <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #4444ff;"><strong>]</strong></span>;</pre>

Como voy a definir todos mis VirtualHost's apuntando hacia "*:80", defino el valor de la llave "*:80" del hash pre-definido <code>$VirtualHost</code> (pre-definido por mod_perl), hacia una referencia de arreglo vacío (por el momento).

<pre>	<strong>for</strong> <strong>my</strong> <span style="color: #2040a0;">$pais</span><span style="color: #4444ff;"><strong>(</strong></span><span style="color: #2040a0;">@{$instancias}</span><span style="color: #4444ff;"><strong>)</strong></span> <span style="color: #4444ff;"><strong>{</strong></span></pre>
Empiezo a interar cada uno de los elementos de <code>$instancias</code> y asigno cada valor en la interación a <code>$pais</code>.
<pre>		<strong>my</strong> <span style="color: #2040a0;">$vhost</span> = <span style="color: #2040a0;">$pais</span>.<span style="color: #008000;">".planetalinux.org"</span>;

		<strong>if</strong> <span style="color: #4444ff;"><strong>(</strong></span><span style="color: #2040a0;">$pais</span> <strong>eq</strong> <span style="color: #008000;">'debian'</span><span style="color: #4444ff;"><strong>)</strong></span> <span style="color: #4444ff;"><strong>{</strong></span>
			<span style="color: #2040a0;">$vhost</span> = <span style="color: #008000;">'planeta.debian.net'</span>;
		<span style="color: #4444ff;"><strong>}</strong></span></pre>

El nombre del servidor será <code>$pais.".planetalinux.org"</code>, a menos que sea "debian", que no lleva el dominio de Planeta Linux.
<pre>		<strong>my</strong> <span style="color: #2040a0;">$virtualh</span> = <span style="color: #4444ff;"><strong>{</strong></span>
			SuexecUserGroup =&gt; <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #008000;">"planetalinux"</span>, <span style="color: #008000;">"planetalinux"</span><span style="color: #4444ff;"><strong>]</strong></span>,
			ServerAdmin =&gt; <span style="color: #008000;">'planetalinux@googlegroups.com'</span>,
			ServerName =&gt; <span style="color: #2040a0;">$vhost</span>,
			DocumentRoot =&gt; <span style="color: #008000;">"/var/www/planetalinux/"</span>.<span style="color: #2040a0;">$vhost</span>,
			ErrorLog =&gt; <span style="color: #008000;">"/var/log/apache2/planetalinux_"</span>.<span style="color: #2040a0;">$pais</span>.<span style="color: #008000;">"_error"</span>,
			CustomLog =&gt; <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #008000;">"/var/log/apache2/planetalinux_"</span>.<span style="color: #2040a0;">$pais</span>.<span style="color: #008000;">"_access"</span>, <span style="color: #008000;">"combined"</span><span style="color: #4444ff;"><strong>]</strong></span>,
			LogLevel =&gt; <span style="color: #008000;">"info"</span>,
			Alias =&gt; <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #008000;">"/images/"</span>, <span style="color: #008000;">"/home/planetalinux/current/www/instancias/"</span>.<span style="color: #2040a0;">$pais</span>.<span style="color: #008000;">"/images/"</span><span style="color: #4444ff;"><strong>]</strong></span>,
			Redirect =&gt; <span style="color: #4444ff;"><strong>[</strong></span><span style="color: #008000;">"/rss20.xml"</span>, <span style="color: #008000;">"http://feedproxy.google.com/"</span>.<span style="color: #2040a0;">$names</span>-&gt;<span style="color: #4444ff;"><strong>{</strong></span><span style="color: #2040a0;">$pais</span><span style="color: #4444ff;"><strong>}</strong></span><span style="color: #4444ff;"><strong>]</strong></span>,
		<span style="color: #4444ff;"><strong>}</strong></span>;</pre>

Aquí defino la referencia al hash principal del virtual host. Los valores son definidos con los nombres de las directivas que utiliza Apache:
<ul>
	<li><code>SuexecUserGroup</code>, pues utilizamos suexec en el servidor se asigna a una referencia de arreglo anónima con dos valores, que son los dos valores que se le pasan a Apache en sus directivas regulares.</li>
	<li><code>ServerAdmin</code>, es el mismo para todas las instancias, nuestra lista de correos.</li>
	<li><code>ServerName</code>, es el nombre que definí previamente como <code>$vhost</code>.</li>
	<li><code>DocumentRoot</code>, depende también de <code>$vhost</code> pues así lo tenemos definido en nuestro sistema de archivos.</li>
	<li><code>ErrorLog</code>, caso similar a <code>DocumentRoot</code>.</li>
	<li><code>CustomLog</code>, caso similar a ErrorLog, pero defino, igual que en <code>SuexecUserGroup</code>, un arreglo anónimo con los dos valores que toma este parámetro.</li>
	<li><code>LogLevel</code>, igual que en Apache.</li>
	<li><code>Alias</code>. Defino un alias simple.</li>
	<li><code>Redirect</code>, puedo utilizar cualquier tipo de directivas, <code>Alias</code>, <code>Redirect</code>, lo que sea. En este caso, realizo la redirección de los viejos feeds <code>"/rss20.xml"</code> hacia la nueva URL de FeedBurner, que es ahora como manejamos los feeds en Planeta Linux. El valor que se concatena al final es el valor del hash <code>%{$names}</code> dada la llave <code>$pais</code>.</li>
</ul>

<pre>		<span style="color: #a52a2a;"><strong>push</strong></span> <span style="color: #2040a0;">@{$VirtualHost{"*:80"}</span><span style="color: #4444ff;"><strong>}</strong></span>, <span style="color: #2040a0;">$virtualh</span>;</pre>
Agrego cada <code>$virtualh</code> al arreglo de VirtualHosts en "*:80". Si tuviera una IP por cada uno de los VirtualHosts, no es necesario hacer push a un arreglo, simplemente tendría que declarar las variables $VirtualHost con la IP como llave. Sin embargo, si declaro muchas veces la misma variable, como en este caso, <code>$VirtualHost{"*:80"}</code>, en cada interación el valor se reescribirá, es por eso que mod_perl nos ofrece definir esa variable como referecia a arreglo en donde podemos meter cuantos virtual hosts como queramos.
<pre>	<span style="color: #4444ff;"><strong>}</strong></span></pre>

Termino el ciclo for.

<code>&lt;/Perl&gt;</code>

Las posibilidades son muchas para la configuración dinámica de Apache y en secciones Perl puedes utilizar cualquier cosa, abrir tus archivos para ver otros parámetros de configuración, conectarte a bases de datos para sacar información, lo que sea.

Si te interesa ver todo el archivo de configuración, está <a href="http://github.com/damog/planetalinux/tree/master/conf/apache.conf">acá</a>, en el <a href="http://github.com/damog/planetalinux">GitHub público de Planeta Linux</a>.