Title: Visit counter
Date: 2004-01-12 14:36:03
Tags: 

<p>Pues bueno, luego de casi dos meses de prometer un visit counter (que se diferencía de un hit counter debido a que el hit counter suma cada recarga del sitio y el visit counter lo hace con cada IP), está listo.

Para instalarlo, hay que instalar antes el hit_counter (para la creación de las tablas en la base de datos, etc.). Las explicaciones para instalar el hit_counter están <a href="http://web.archive.org/web/20040128181544/http://damog.net/index.php?gadget=blog&amp;action=single_view&amp;id=52">acá</a>.

Una vez instalado el hit_counter, hay que reemplazar el hit_counter.php por este otro:

<a href="http://web.archive.org/web/20040128181544/http://www.damog.net/files/hit_counter-2.phps"><a href="http://www.damog.net/files/hit_counter-2.phps">http://www.damog.net/files/hit_counter-2.phps</a></a>

A este nuevo archivo, también hay que llamarlo hit_counter.php, o sea, hay que sobreescribir el anterior.

Ahora sólo falta crear una tabla en la base de datos, la cual nos servirá para guardar todas las IP&#8217;s. Por default, cada 15 días (cada día 7 y 21, de cada mes -gracias a <a href="http://web.archive.org/web/20040128181544/http://www.mexska.org/%7Ewieland">Wieland</a> por la sugerencia-) se borra la tabla, para permitir nuevamente las IP&#8217;s que hayan sido guardadas con anterioridad:
</p>
<pre>mysql&gt; CREATE TABLE ipvisitor (ip VARCHAR(255));</pre>
<p>
¡Y listo! ;-)
</p>
<h3>¿Cuál es la diferencia exacta entre un contador de hits y uno de visitas?</h3>
<p>
Es muy simple.

Un hit counter suma un dígito en cada recarga del sitio (o en cada momento que la parte del script del hit counter es ejectuado, o &#8216;mandado llamar&#8217;). Un visit counter, cuenta visitas <strong>reales</strong>, suma un dígito cuando una IP diferente ejecuta el script.

Enjoy. </p>
