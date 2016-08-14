title: "Manejo del tiempo con Perl"
date: 2007/8/31 22:46:54
Tags:
---
<h2>
<strong>Manejo</strong> <strong>del</strong> <strong>tiempo</strong> <strong>con</strong> <strong>Perl</strong>
</h2>
<p><a href="http://www.damog.net/columnapl" target="_blank">La Columna.pl</a> #1 - Mayo 21, 2007.

Recientemente, por algunas de las necesidades que <a href="http://raquelhernandez.net/" target="_blank">tuvimos</a> en el trabajo, necesitamos manejar de alguna forma fechas y horas desde nuestros scripts y aplicaciones en <a href="http://www.perl.com/pub/a/1999/03/pm.html" target="_blank"><strong>Perl</strong></a>. Hace no-sé-cuántos años, los franceses propusieron un sistema decimal para manejar el <strong>tiempo</strong>, pero el método fue impopular entre la comunidad científica. Si hubiera sido así, manejar las fechas y horas en cualquier sistema, hubiera sido tan fácil que no habría tantas implementaciones para trabajar <strong>con</strong> él, como hoy en día. Pero bueno, el hubiera no existe.

En <strong>Perl</strong> a veces nos confunde sobre si necesitamos usar <a href="http://perldoc.perl.org/functions/localtime.html" target="_blank">localtime</a>, <a href="http://perldoc.perl.org/functions/time.html" target="_blank">time</a>, <a href="http://perldoc.perl.org/functions/gmtime.html" target="_blank">gmtime</a>, <a href="http://search.cpan.org/%7Edrolsky/DateTime-0.37/lib/DateTime.pm" target="_blank">DateTime.pm</a>, etc. para trabajar <strong>con</strong> el <strong>tiempo</strong>. En realidad es mucho más sencillo de lo que parece. Espero que estas minirecetas le sirvan a alguien cuando encuentre este texto buscando por ahí en la red el <strong>manejo</strong> <strong>del</strong> <strong>tiempo</strong> <strong>con</strong> <strong>Perl</strong>. Lo haré a manera de FAQ.

¿Cómo obtengo la fecha actual?
La función localtime nos devuelve la fecha actual, pero lo hace en forma de una lista de 9 elementos que podemos obtener de una manera sencilla:

my @fecha = localtime; # La lista tiene el formato (seg, min, hora, día mes, mes, año, día sem, día año, DST).

De esta forma, cada uno de los elementos <strong>del</strong> arreglo @fecha, será, por orden, el de ese formato, de ahí podrías usar $fecha[0] para obtener el segundo, $fecha[1] para los minutos, y así sucesivamente. Puedes obtener más información en perldoc -f localtime.

¿Y time? ¿Qué es? ¿Cuándo lo utilizo? ¿localtime no se mandaba llamar como localtime(time)?

La función time nos regresa la cantidad de segundos desde el epoch, léase, el 1 de enero de 1970, UTC, como en la mayoría de los sistemas actuales. time realmente lo hace desde cualquier epoch de acuerdo a la arquitectura de la máquina, pero supondremos que ese no es el caso.

damog@cochina:~$ <strong>perl</strong> -e ‘print time.”\n”;’
1179168385
localtime toma como parámetro una cierta cantidad de segundos. Por default, toma el valor de time. Así que podemos usar tanto localtime como localtime(time) cuando usemos dicha función.

Pero lo que yo quiero es obtener la fecha en el formato que yo quiera.

Tienes dos opciones. Una, es usar el contexto escalar de localtime, es decir, tratar lo que nos regresa localtime como una variable escalar, no como una lista. Ejemplo:

damog@cochina:~$ <strong>perl</strong> -e ‘$fecha = localtime; print $fecha, “\n”;’
Wed May 16&#160;19:29:55&#160;2007
damog@cochina:~$

Sencillo, ¿no? Lo cual es lo mismo que usar la función scalar, sin tener que asignar forzosamente a una variable escalar:

damog@cochina:~$ <strong>perl</strong> -e ‘print scalar localtime, “\n”‘
Wed May 16&#160;19:30:55&#160;2007
damog@cochina:~$

Puedes echar un ojo a <a href="http://perldoc.perl.org/perllocale.html" target="_blank">perllocale</a> si es que la fecha te interesa en otro idioma.

Lo más sencillo, desde mi muy personal punto de vista, y la otra opción, es usar strftime. No hay que temer a usarlo, básicamente utiliza la misma sintaxis que su predecesor, strftime de C. A final de cuentas es bien sencillo (incluso a veces yo echo un rápido vistazo a la página de strftime de PHP que explica cómo usar la función y es la misma implementación). Esta función se encuentra en el módulo estándar <a href="http://perldoc.perl.org/POSIX.html" target="_blank">POSIX</a>, que podría ser que ya tengas cargado en tu distribución o sistema operativo. Lo que strftime necesita, es el formato en el que necesitas la fecha, y el <strong>tiempo</strong> en segundos desde el epoch.

Supongamos que queremos la fecha <strong>del</strong> día de hoy, en el formato AAAA-MM-DD:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use POSIX qw(strftime);
&gt; print strftime(”%Y-%m-%d”, localtime), “\n”;
&gt; ‘
2007-05-17
damog@cochina:~$

¿Muy simple, no?

Incluso, si queremos hacer un poco de matemáticas <strong>con</strong> días, lo podemos hacer <strong>con</strong> strftime, por ejemplo, queremos la fecha de ayer en formato AAAA-MM-DD hh-mm-ss:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use POSIX qw(strftime);
&gt; print strftime(”%Y-%m-%d %H:%M:%S”, localtime(time - 86400)), “\n”;
&gt; ‘
2007-05-16&#160;10:14:06
damog@cochina:~$
Como que no entendí muy bien eso de los contextos de localtime. ¿Me lo podrías aclarar?

Claro. localtime es manejado por <strong>Perl</strong> desde dos conceptos para su valor de retorno. Uno es el contexto de escalar y uno en el contexto de lista (como sabes, <strong>Perl</strong> utiliza estos dos tipos -u otros- de conceptos para el <strong>manejo</strong> de sus variables). El contexto escalar de localtime es el que nos regresa una fecha formateada (puedes echar un ojo también a la función scalar, si tienes duda al respecto); el contexto de lista de localtime nos regresa un arreglo, donde cada uno de sus elementos, corresponde a un atributo de la fecha, como la documentación de la función nos lo indica y como lo indicaba líneas arriba. Es bien simple.

De hecho, los conceptos de escalar y lista es muy simple. Una variable escalar puede contener cadenas, valores numéricos, referencias, etc. Una variable de lista son arreglos, los cuales, a su vez, contienen elementos escalares, listados en ellos. Como una nota al margen, actualmente las variables escalares de las listas son manejadas de la forma $arreglo[2], por ejemplo, así es como <strong>Perl</strong> 5 lo maneja. En <a href="http://dev.perl.org/perl6/" target="_blank"><strong>Perl</strong> 6</a> se utilizarán los elementos de las listas de la forma @arreglo[2], lo cual es mucho más intuitivo y natural, pero mientras <strong>Perl</strong> 6 no vea la luz oficialmente, esta nota queda sólo como una acotación adicional :-)

Aún se me hace un poco complicado, ¿no hay una forma más fácil?

¡Desde luego! There is more than one way to do it. Hay una cantidad enorme de módulos de fecha y hora disponibles en <a href="http://search.cpan.org/">CPAN</a>, sin embargo, el que ha gozado de gran aceptación por su buena implementación y diseño, es DateTime.

<strong>Con</strong> DateTime podemos manejar fechas y tiempos en una forma mucho más natural e intuitiva, podemos hacer operaciones matemáticas de una forma mucho más lingüística, que puede terminar ayudando mucho más la naturaleza y la lógica de nuestros programas:

¿Cómo puedo obtener la hora actual <strong>con</strong> DateTime?

Bien simple:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use DateTime;
&gt;
&gt; my $hoy = DateTime-&gt;now();
&gt; print $hoy, “\n”;
&gt; ‘
2007-05-17T16:26:12
damog@cochina:~$

Sin embargo, hay que ser un poco cuidadosos al usar el método now() pues nos regresa la fecha en UTC. Para eso, podemos crear el objeto $hoy, especificando nuestra zona horaria:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use DateTime;
&gt; my $hoy = DateTime-&gt;now(time_zone =&gt; “America/Chicago”);
&gt; print $hoy, “\n”;
&gt; ‘
2007-05-17T11:29:51
damog@cochina:~$

Ese objeto, puede ser utilizado para muchas más cosas. Por ejemplo, a una fecha, sumarle un mes, no es lo mismo que sumarle 28 días, ó 30, ó 31. Mira este ejemplo, donde crearemos un objeto DateTime <strong>con</strong> una fecha en el pasado y le sumaremos un mes y luego le restaremos dos años:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use DateTime;
&gt; my $fecha = DateTime-&gt;new(
&gt; year =&gt; 1984,
&gt; month =&gt; 8,
&gt; day =&gt; 8,
&gt; hour =&gt; 2,
&gt; minute =&gt; 0);
&gt; print $fecha-&gt;add(months =&gt; 1), “\n”;
&gt; print $fecha-&gt;add(years =&gt; -2), “\n”;
&gt; print “DateTime es la onda!\n”;
&gt; ‘
1984-09-08T02:00:00
1982-09-08T02:00:00
DateTime es la onda!
damog@cochina:~$

Podemos ver que creamos un objecto DateTime llamado $fecha que apunta hacia el 8 de agosto de 1984, 2 de la mañana. A él, le sumamos un mes y luego le restamos dos años. Simple, ¿no crees?

¿Y cómo puedo hacer una diferencia de fechas?

Creo que lo más sencillo para utilizar, es Date::Manip. Observa este ejemplo:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use Date::Manip;
&gt; my $hoy = ParseDate(”today”);
&gt; my $fecha_nacimiento = ParseDate(”1984-08-08&#160;02:00:00″);
&gt; $delta = DateCalc($fecha_nacimiento, $hoy, \$err, 1);
&gt; print $delta, “\n”;
&gt; ‘
+22:9:1:2:9:55:34
damog@cochina:~$

Básicamente, creamos dos cadenas, $hoy y $fecha_nacimiento y luego las pasamos por &amp;DateCalc, que requiere ambas fechas, una referencia a una variable de error y la variable 1, como modo de operación que nos hará la diferencia entre ambas fechas. Esto nos regresa una cadena parseable para el método &amp;ParseDateDelta, cuyo formato nosotros podemos utilizar y parsear:

my ($anos, $meses, $semanas, $dias, $horas, $minutos, $segundos)

= $delta =~ /^\+(\d+):(\d+):(\d+):(\d+):(\d+):(\d+):(\d+)$/;

Echando rápidamente una mirada a la cadena, podemos saber que en el momento de escribir esta guía, tengo 22 años, 9 meses, 1 semana, 2 días, 9 horas, 55 minutos y 34 segundos de vida. :-)

¿Pero y si quiero convertir una cierta fecha a segundos desde el epoch?

El módulo POSIX también proporciona una función bien sencilla llamada <a href="http://perldoc.perl.org/POSIX.html" target="_blank">mktime</a> que puede ser usada para precisamente esto.

Como puede verse en la documentación de esta función, la sintaxis es la siguiente:

mktime(sec, min, hour, mday, mon, year, wday = 0, yday = 0, isdst = 0);

Quiero saber la cantidad de segundos hasta el momento que mis padres me han dicho que nací, 2 am, <strong>del</strong> 8 de agosto de 1984. El valor mon es contabilizado desde 0, el cual es enero, y así sucesivamente hasta el 11 que es diciembre. De forma similar <strong>con</strong> wday y yday. El argumento year, empieza desde 1900. Dicho lo anterior, podemos calcular:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use POSIX qw(mktime);
&gt;
&gt; print mktime(0, 0, 2, 8, 7, 84), “\n”;
&gt; ‘
460800000
damog@cochina:~$

Ahí utilizamos 0 para el segundo, 0 para el minuto, 2 para la hora, 8 para el día <strong>del</strong> mes, 7 para el mes <strong>del</strong> año (agosto, recordemos que empiezan desde cero) y 84 para el año desde 1900. Nací en el segundo 460800000 desde el epoch. Pero vamos a ver si eso es cierto, usaremos una combinación de mktime y localtime, en su contexto escalar:

damog@cochina:~$ <strong>perl</strong> -e ‘
&gt; use POSIX qw (mktime);
&gt;
&gt; print scalar localtime(mktime(0, 0, 2, 8, 7, 84)), “\n”;
&gt; ‘
Wed Aug  8&#160;02:00:00&#160;1984
damog@cochina:~$

Parece que así es :-) Nací en el segundo  460800000. Era miércoles :-)

Como puedes ver, no es la gran cosa procesar fechas y horas en <strong>Perl</strong>, realmente es sencillo y sólo es cosa de excarvarle un poquito por aquí y por allá y usar cinta adhesiva para obtener lo que queremos de una forma eficiente y útil.

Ojalá te sirva, espero que te hayas divertido aprendiendo un poquito sobre el <strong>tiempo</strong> en <strong>Perl</strong> así como yo me divertí escribiendo. Puedes hacerme llegar tus comentarios a &lt;<a href="mailto:damog@ciencias.unam.mx" target="_blank">damog@ciencias.unam.mx</a>&gt;.

Información extendida recomendada:
</p>
<ul>
<li><a href="http://www.perl.com/pub/a/2003/03/13/datetime.html" target="_blank">The Many Dates and Times of <strong>Perl</strong></a></li>
<li><a href="http://perl.about.com/od/perltutorials/a/perllocaltime.htm" target="_blank">How to tell the current time in <strong>Perl</strong></a></li>
<li><a href="http://www.stonehenge.com/merlyn/UnixReview/col25.html" target="_blank">Getting a date with <strong>Perl</strong></a></li>
<li><a href="http://datetime.perl.org/?FAQ" target="_blank">DateTime Project FAQ</a></li>
</ul>
<hr>
<p>
Sobre el autor: Durante el día, David Moreno Garza (<a href="http://www.damog.net//" target="_blank">damog</a>) desarrolla aplicaciones, sistemas y proyectos para una incipiente empresa internacional de telecomunicaciones; adicionalmente es consultor independiente en empresas mexicanas y extranjeras utilizando <strong>Perl</strong>. Durante la noche intenta salvar al mundo <strong>del</strong> mal usando expresiones regulares y netiquette.
</p>
<hr>
<p>
Copyright © 2007 David Moreno Garza.This material may be distributed only subject to the terms and conditions set forth in the Open Publication License, v1.0 or later (the latest version is presently available at <a href="http://www.opencontent.org/openpub/"><a href="http://www.opencontent.org/openpub/">http://www.opencontent.org/openpub/</a></a>). </p>
