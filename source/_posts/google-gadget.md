title: "Google gadget"
Date: 2003-11-09 19:38:53
Tags: 
---
<p>Pues he terminado un pequeño gadgetcito para <a href="http://web.archive.org/web/20031125134728/http://jaws-project.sf.net/">JAWS</a> para hacer búsquedas en <a href="http://web.archive.org/web/20031125134728/http://www.google.com/">Google</a>. Espero adaptarle un pequeño admin, pero por lo pronto es usable.

Para instalarlo, hay que hacer lo siguiente (ahora que lo pienso, estaría bien que JAWS tuviera una interfacecita para adhesión de gadgets nuevos, a ver qué se puede hacer).
</p>
<ul>
<li>Bajar <a href="http://web.archive.org/web/20031125134728/http://damog.net/files/google.phps">éste</a> archivo PHP.
<pre>% wget <a href="http://www.damog.net/files/google.phps">http://www.damog.net/files/google.phps</a></pre>
Hay que renombrarlo a google.php, el google.phpS es para que se muestre el contenido.</li>
<li>Poner el archivo en el directorio de gadgets de JAWS.
<pre>% mv /ruta/al/archivo/google.php raíz_de_jaws/gadgets</pre>
</li>
<li>Añadir el gadget en la tabla &#8216;registry&#8217;. Si se está usando JAWS 0.2 se pueden insertar en el registro 35:
<pre>mysql&gt; INSERT INTO registry VALUES (35,'/gadgets/google/enabled','true');</pre>
</li>
<li>Listo! Ya se puede cargar el gadget desde el Control Panel de JAWS. Hasta el momento, sólo está languagizado con spanish e english. En cuanto ponga una administracioncita para el gadget (tamaño y tipo de la imagen de Google, orden de los botones, etc), pondré más traducción en ./languages.</li>
</ul>
<p>
:-D </p>
