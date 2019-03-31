---
title: "{ primera secuencia de 10 dígitos de Pi, que sumados dan 13 } .com"
date: 2006-11-07 17:58:04
tag: 
---
<p>La semana pasada encontré en la <a target="_blank" href="http://www.fciencias.unam.mx">Facultad</a> algo interesante. Como la mayoría de los días, caminaba por los pasillos adormilado y sintiendo a cada paso la flojera de hacer cualquier cosa en la vida cuando vi un anuncio pegado en una de las paredes con algo que decía más o menos así:
</p>{ primera secuencia de 10 dígitos de Pi, que sumados dan 13 } .com<p>
Me quedé un rato mirando el cartel que debajo de lo escrito indicaba: &#8220;Fecha límite: 3 de noviembre&#8221; y tenía el escudo de la <a target="_blank" href="http://www.ingenieria.unam.mx">Facultad de Ingenería</a>. A veces mi atención no es lo suficientemente grande así que me quedé para intentar entender el problema o que mis ojos lo estaban viendo bien y el cerebro no me hacía una jugada chueca, como es su costumbre. Luego pensé en quién sería que pusiera ese cartel, ¿sería algún proyecto de los ingenieros? ¿Algún proyecto de clase? ¿Alguna empresa relacionada de alguna forma con ellos?

Me quedé parado viendo el cartel y entendiéndolo. Algo que muchas veces sufro estudiando una carrera como Matemáticas, aunado a mi pésima memoria y concentración, es que a veces no entiendo lo que leo. Simplemente lo leo, pero como que no me entra a los huesos, pero como esto sí me interesó me pasé como diez minutos viendo el cartel.

&#8220;Primera secuencia&#8221;. Una secuencia es una cadena de números consecutivos, secuenciales desde luego. <a target="_blank" href="http://en.wikipedia.org/wiki/Pi">Pi</a> tiene una cantidad infinita de secuencias, claramente. &#8220;De diez dígitos&#8221;. OK, diez números seguidos es una secuencia de diez dígitos. &#8220;De pi&#8221;, obviamente de Pi. Estos güeyes se fusilaron el acertijo de un problema similar de Google que referenciaba a e, pero bueno, a nosotros nos concernía Pi. &#8220;Que sumados dan 13&#8221;. Al sumar los diez dígitos de esa primera secuencia de Pi, me debe dar 13. Creo que ya entendí lo que me están pidiendo.

Si los primeros, digamos, 18 dígitos de Pi son 3.14159265358979323, entonces la primera secuencia de diez dígitos es 3.141592653. Sumando cada uno de esos dígitos obtenemos 39. No es 13. Así que nos seguimos con la segunda secuencia de diez dígitos que sería 1415926535, cuya suma nos da 41. Y así me tengo que ir hasta que alguna secuencia me dé 13.

El siguiente problema era obtener un número de Pi lo suficientemente grande para que me dejara contar muchas secuencias. El domingo cuando fui a casa de Jordi a padrotearlo un rato y le conté de este asunto me dijo con su naquez acostumbrada: &#8220;Pues tú también hubieras calculado un número de Pi, tssss&#8230;&#8221;. Pero no, me vi suficientemente güevón y busqué un número de Pi muy grande en Internet. Hay algunas páginas que te ofrecen un número de Pi de hasta 10&#8217;000 dígitos, otros de 100&#8217;000, y otros de varios millones de dígitos. Así que utilicé el archivo de Pi del <a href="http://www.gutenberg.org/wiki/Main_Page">proyecto Gutenberg</a> que contiene 1&#8217;250&#8217;000 dígitos de Pi (pueden verlo original desde <a href="ftp://ibiblio.org/pub/docs/books/gutenberg/etext93/pimil10.txt">aquí</a>).

¿Y con qué más? Pues con Perl ;-) Ya teniendo identificado el problema y teniendo un número de Pi grandotototote, lo que me restaban eran dos cosas. Como era más fácil editar el archivo de texto del número de Pi y quitarle todo el texto, disclaimers y demás cosas que tiene  al principio para dejar únicamente los números así lo hice y mi archivo resultante, el que usé en mi código chafa de Perl es <a href="http://damog.net/files/scripts/secuencia-pi/pimil10.txt">éste</a>.

</p>
<pre>
<code>
#!/usr/bin/perl

use warnings;
use strict;

open(P, 'pimil10.txt');
my $string;

{
s/\n//g;
s/\s+//g;
$string .= $_;
} while(<p>);

for(my $i = 0; $i
</p></code></pre>
<p>

Y así tenemos, en las últimas diez líneas de la salida:

</p>
<pre>
13714 | 0448991721 = 45
13715 | 4489917210 = 45
13716 | 4899172100 = 41
13717 | 8991721002 = 39
13718 | 9917210022 = 33
13719 | 9172100222 = 26
13720 | 1721002220 = 17
13721 | 7210022201 = 17
13722 | 2100222013 = 13
POR FIN!
</pre>
<p>

Eso nos indica que la secuencia &#8220;2100222013&#8221; es la que suma 13 y está en la ubicación 13&#8217;722 de dígitos de Pi. :-) Finalmente tenemos que <a href="http://2100222013.com">2100222013.com</a> es la URL que nos esperaba :-) En estos momentos el sitio ya no pone la felicitación que ponía la semana pasada (como decía, había un límite de tiempo para entrar al sitio.

De cualquier forma, aquí pongo un screenshot que tomé cuando entré al sitio. Estaba muy emocionado, pues no sabía qué me esperaba al descubrir el sitio :-)

</p>
<p align="center"><a href="http://www.damog.net/files/misc/pi-felicitaciones.png"><img src="http://www.damog.net/files/misc/pi-felicitaciones-mini.png" alt="Pi"/></a></p>
<p>

Fue muy divertido :-) Ya luego me puse más de curioso y vi quién había registrado el sitio usando whois y así. </p>
