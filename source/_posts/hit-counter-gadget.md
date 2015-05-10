Title: Hit Counter gadget
Date: 2003-11-13 19:36:08
Tags: 
---
<p>Pues continuando de colaborar con <a href="http://web.archive.org/web/20031125134728/http://jaws-project.sf.net/">JAWS</a> un poquito, me hice <a href="http://web.archive.org/web/20031125134728/http://www.damog.net/files/hit_counter.phps">éste</a> gadget que cuenta los hits que se hacen del sitio.

Hay que crear una tabla dentro de la base de datos de JAWS, es muy sencillo: Nos ubicamos en el prompt de MySQL y empezamos:
</p>
<pre>mysql&gt; USE base_de_datos_de_jaws;



mysql&gt; CREATE TABLE counter (visits int(9));



mysql&gt; INSERT INTO counter VALUES (0);



mysql&gt; INSERT INTO registry VALUES (36,'/gadgets/hit_counter/enabled','true');</pre>
<p>
Algunas observaciones:
</p>
<li>Obviamente puede usarse cualquier otro tipo de parámetro para la columna &#8216;visits&#8217; de la tabla &#8216;counter&#8217;. Sobre todo, si el sitio recibe más de 999&#8217;999&#8217;999 de visitas :P</li>
<li>El &#8216;id&#8217; del &#8216;INSERT INTO registry&#8230;&#8217; depende del último registro que se tenga en la tabla.

Ahora, copia el código del archivo:

<a href="http://web.archive.org/web/20031125134728/http://damog.net/files/hit_counter.phps"><a href="http://www.damog.net/files/hit_counter.phps">http://www.damog.net/files/hit_counter.phps</a></a>

(Ojo con la &#8216;ESE&#8217; al final del nombre del archivo)

Y pégalo en el archivo &#8216;raíz_de_jaws/gadgets/hit_counter.php&#8217;

Por último, edita el archivo hit_counter.php en la línea 33, para que despliegue la fecha en que insertas el gadget.

Y listo, ya puedes ponerlo desde tu Control Panel de JAWS.</li>
