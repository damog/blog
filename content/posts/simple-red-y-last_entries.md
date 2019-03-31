---
title: "simple-red y last_entries"
date: 2003-12-01 19:27:21
tag: 
---
<p>Un par de cosas.

Pues hice una ligera modificación al tema &#8216;simple-blue&#8217; de <a href="http://web.archive.org/web/20031226230140/http://jaws-project.sf.net/">JAWS</a> para ponerlo rojito, como el que se está viendo ;)

<a href="http://web.archive.org/web/20031226230140/http://www.damog.net/themes/simple-red/estilo.phps?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">Acá</a> está el estilo.css del &#8216;simple-red&#8217;. Yo lo tengo nombrado como un archivo PHP, debido a que mando llamar un script desde el CSS, solamente se tiene que reemplazar la palabra &#8216;randomimage.php&#8217; de la línea 23, por el nombre de la imagen de la cabecera.

Otra cosa, un truquito&#8230; Como bien conoce todo usuario del weblog, JAWS manda al histórico todos los mensajes de un mes que acaba de terminar, cuando encuentra un mensaje nuevo fechado por un mes nuevo. Para evitar eso -si es que no te agrada, como a mí-, hay que hacer un par de cositas en MySQL:
</p>
<pre>mysql&gt; UPDATE registry SET value='last_entries' WHERE id=20;</pre>
<p>
Aquí le decimos a JAWS que despliegue las últimas entradas en blog, en vez de hacerlo mensualmente, como está especificado por default. El id 20 es &#8216;/gadgets/blog/default_view&#8217;.

Ahora, hay que definir el número de entradas que se desplagarán en total:
</p>
<pre>mysql&gt; UPDATE registry SET value=VALOR_DESEADO where id=21;</pre>
<p>
Y listo. Ésto para quienes no conozcan bien el acomodo de datos en base de datos de JAWS. </p>
