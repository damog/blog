Title: JAWS links gadget
Date: 2003-12-13 19:21:42
Tags: 
---
<p>Pues por fin he termino el primer release :P de mi famosísimo <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/index.php?gadget=links&amp;PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">links gadget</a>.

Este gadget es un módulo en el cual se pueden dar de alta <em>nuestros enlaces favoritos</em> poniendo el nombre del sitio, la URL y una breve descripción. <a href="http://web.archive.org/web/20031226230140/http://www.jaws.com.mx/">JAWS</a>, pensado como un blog personal permite este tipo de gadgets como un plus más, para los visitantes y conocer por medio de enlaces favoritos, al blogger :P

Entremos en materia. Hay cinco partes en que se divide el gadget.
</p>
<ol>
<li>Módulo de administración.</li>
<li>Template para el despliegue del gadget.</li>
<li>Imagen para ponerse en el Control Panel.</li>
<li>Template para la administración del gadget.</li>
<li>Inserción en SQL (inserción en &#8216;registry&#8217; y creación de tabla).</li>
</ol>
Los tres primeros archivos se encuentran ya acomodados en <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/links-gadget.tar.gz?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">este tarball</a>. Se tiene que desempaquetar en el directorio &#8216;raiz&#8217; de JAWS (en mi caso personal es /home/damogar/www):
<pre>$ cd $JAWS

$ wget <a href="http://www.damog.net/files/links-gadget.tar.gz">http://www.damog.net/files/links-gadget.tar.gz</a>

$ tar xzvf links-gadget.tar.gz</pre>
Al desempaquetarlo, se van a acomodar los archivos necesarios para el gadget:
<ul>
<li>&#8216;<a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/links.phps?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">links.php</a>&#8217; dentro de $JAWS/gadgets/</li>
<li>&#8216;<a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/admin.links.htmls?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">admin.links.html</a>&#8217; dentro de $JAWS/templates/controlpanel/</li>
<li>&#8216;<a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/links.png?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">links.png</a>&#8217; dentro de $JAWS/images/gadgets/</li>
<li>&#8216;<a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/links.htmls?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">links.html</a>&#8217; dentro de $JAWS/templates/</li>
</ul>
<strong>Recalco:</strong> Mientras el tarball se desempaquete en el directorio raíz de JAWS, no es necesario mover manualmente los archivos.

Listo, ya tenemos acomodados los archivos. Lo siguiente será lidiar un poco con la base de datos:
<pre>mysql&gt; INSERT INTO registry VALUES (38,'/gadgets/links/enabled','true');</pre>
Aquí podemos sustituir el valor del &#8216;38&#8217; por el del siguiente del último registro de la tabla &#8216;registry&#8217;. Tip: Por default, JAWS tiene 34 registros en esa tabla (pero lo puedes checar con &#8216;SELECT * FROM registry&#8217;).

Después simplemente creamos la tabla que estará destinada al gadget:
<pre>mysql&gt; CREATE TABLE link (user_id int(11), link varchar(255), url varchar(255), description blob);</pre>
Y listo. Por default, el user_id de cada inserción de datos, se hace como &#8216;0&#8217;, el user_id del administrador.

Claro, se puede ver el gadget en acción <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/index.php?gadget=links&amp;PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">aquí</a>. Cualquier comentario u observación, háganmela saber.
