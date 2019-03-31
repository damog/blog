---
title: "Pequeñas herramientas para grandes necesidades"
date: 2007-08-31 22:44:51
tag: 
---
<p id="post-664"><strong>Pequeñas herramientas para grandes necesidades</strong></p>
<ul>
<li>
<a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#la_columna_pl__2">La <strong>Columna</strong>.<strong>pl</strong> #<strong>2</strong></a>
<ul>
<li>
<a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#peque%20%20%20_as_herramientas_para_grandes_necesidades">Pequeñas herramientas para grandes necesidades</a>
<ul>
<li><a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#referencias_%20%20%20%20%20%20tiles">Referencias útiles</a></li>
</ul>
</li>
<li><a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#autor">Autor</a></li>
<li><a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#licencia_de_uso">Licencia de uso</a></li>
</ul>
</li>
<li><a href="http://www.damog.net/columnapl/pequenas-herramientas-para-grandes-necesidades/#sobre_la_columna_pl">Sobre <em>La <strong>Columna</strong>.<strong>pl</strong></em></a></li>
</ul>
<hr>
<h1>
<a title="la_columna_pl__2" name="la_columna_pl__2" id="la_columna_pl__2"></a>La <strong>Columna</strong>.<strong>pl</strong> #<strong>2</strong>
</h1>
<h2>
<a title="peque   _as_herramientas_para_grandes_necesidades" name="peque%20%20%20_as_herramientas_para_grandes_necesidades" id="peque   _as_herramientas_para_grandes_necesidades"></a>Pequeñas herramientas para grandes necesidades</h2>
<p>
Se han pasado muy rápidamente estos últimos 15 días. Entre algunas pláticas, trabajo y otras cosas, pareciera que el tiempo simplemente se esfuma tan, tan rápidamente.

Como sea, ya estamos en la segunda entrega de <em>La <strong>Columna</strong>.<strong>pl</strong></em>. En esta quincena quiero tocar un tema bien interesante que son esas pequeñas herramientas que nos pueden llenar de una manera muy especial alguna de nuestras necesidades. ¿Hay algo por ahí que quieras automatizar pero no te decides? Inténtalo.

El ejemplo que voy a poner aquí es acerca de una pequeña utilidad que hice para revisar el estado de la batería de mi laptop. Como es bien sabido por algunos de ustedes, amables lectores, utilizo una máquina <em>PowerBook G4</em>, sobre <em>Debian GNU/Linux</em>: En esta máquina hago la mayoría de mi trabajo, que se basa principalmente en desarrollo de software y algo de administración de sistemas. La mayoría de mi trabajo lo hago en esta máquina que es casi tan estable como una piedra. En fin, las computadoras <em>Apple</em>, como ésta, utilizan un microcontrolador que gestiona las funcionalidades de energía, tales como el control de suspensión, el nivel de batería y otras similares, llamado PMU. Lamentablemente las aplicaciones actualmente existentes que monitorean los atributos de PMU, en Linux sobre estas computadoras no me satisfacen del todo: Algunas son unas aplicaciones en <em>GTK</em> verdaderamente estorbosas; otras están integradas al panel de control de <em>GNOME</em> o <em>KDE</em>, del cual no utilizo ninguno. Opté por utilizar el control de batería de <em>GKrellM</em>, que es algo modesto, pero que de todas formas a veces no quería tener siempre en mi escritorio - que para empezar, no es que tenga un escritorio como tal, pues de un escritorio sólo utilizo algunos escritorios virtuales y algo de soporte de systray. Finalmente no estaba muy seguro de lo que necesitaba. Lo único seguro era mi inseguridad en el caso <img src="http://www.damog.net/wp-includes/images/smilies/icon_smile.gif" alt=":-)"/>

¡Una pequeña aplicación en Perl! Claro, desde un emulador de terminal podría llamar esta aplicación y me diría qué porcentaje tengo de batería restante en mi máquina, sería lo más simple, sencillo y a mi gusto, sería perfecto. Pues vamos a poner las manos a la obra.

En mi máquina, la información de la batería se encuentra en /proc/pmu/battery_0, que luce así:
</p>
<pre> flags      : 00000011 charge     : 3535

max_charge : 3537

current    : 0

voltage    : 12495

time rem.  : 0</pre>
<p>
El archivo indica diferentes valores para amperaje y voltaje. Los que me interesan son los valores de charge y max_charge que indican miliampers/hora de la carga actual que tiene la pila y la máxima.

Lo que hay que hacer es bastante simple. Obtener el valor de charge, el de max_charge y obtener un porcentaje del primero con respecto al segundo. En esta columna tocaré algunos temas básicos pero que pueden ser de utilidad para entender algunos conceptos más adelante en otras columnas.
</p>
<pre> #!/usr/bin/perl use warnings;

use strict;</pre>
<p>
Mando llamar al intérprete de Perl que en la mayoría de las distribuciones con binarios precompilados irá a dar a <code>/usr/bin/perl</code> e inmediatamente mando llamar dos pragmas de Perl: El primero, <code>warnings</code>, para controlar advertencias y el segundo, <code>strict</code>, para restringir construcciones inseguras. Es bueno siempre llamar ambos pragmas para educarnos un poco al programar. Un pragma es únicamente un indicador para el momento de la compilación, podremos estudiar un poco los pragmas en futuras columnas.
</p>
<pre> my $pmufile = '/proc/pmu/battery_0';</pre>
<p>
Declaro la variable <code>$pmufile</code> que indicará la ruta absoluta del archivo que mencionaba anteriormente.
</p>
<pre> my $filecont; {

local $/ = undef;

open(PMU, $pmufile) or die $!;

$filecont = &lt;PMU&gt;;

}</pre>
<p>
Aunque el uso de <code>local</code> ya no se aconseja mucho, es bueno a veces para utilizarlo en bloques específicos donde sólo tengamos que modificar, quizás, una variable especial, como en este caso, la variable especial <code>$/</code>. Esta variable nos sirve para definir el <em>input record separator</em>, que por default, es una línea nueva. Modificarlo nos permite hacer cosas interesantes, sobre todo cuando efectuamos un ciclo <code>while()</code> hacia un filehandle. En este caso, indefinimos su valor, por lo cual, luego de abrir el archivo <code>$filename</code> a lectura, vaciamos todo el contenido del archivo en una sola variable, <code>$filecont</code>, que habíamos declarado antes del bloque. En alguna columna futura tengo pensado tratar a fondo las variables especiales, que son algo muy interesante dentro de Perl.
</p>
<pre> my($charge) = $filecont =~ /charges+:s(d+)/; my($max_charge) = $filecont =~ /max_charges+:s(d+)/;</pre>
<p>
Aquí creamos las variables <code>$charge</code> y <code>$max_charge</code> y les asignamos el valor que nos arroja nuestra expresión regular como la variable especial <code>$1</code>, en ambas líneas.
</p>
<pre> my $porc = int (($charge/$max_charge) * 100);</pre>
<p>
Dividimos <code>$charge</code> entre <code>$max_charge</code> y multiplicamos el resultado por cien, para obtener el porcentaje. Sin embargo, este resultado nos arrojaría más de diez decimales, después del punto. Por ello, utilizamos la función de Perl, <code>int</code>, que nos regresa el valor entero de su parámetro (mi incipiente naturaleza matemática me hace hacer notar que un número entero no es necesariamente un número natural :-)).
</p>
<pre> print "t", "Restante: $porc %", "n";</pre>
<code>print</code><p> en realidad requiere una lista como argumento, lo que generalmente hacemos en enviarle un sólo parámetro (por ejemplo, <code>print "Hola mundo";</code>), sin embargo, para una notación mucho más intuitiva, ponemos el salto de línea y el tabulador como primer y tercer parámetro, una lista, precisamente.

¡Y listo! Le agrego un bit de ejecución al script, lo renombro a <code>pila</code>, lo pongo en <code>/usr/local/bin</code> o algo similar y puedo correrlo fácilmente:
</p>
<pre> damog@cochina:~$ pila         Restante: 86 %

damog@cochina:~$</pre>
<p>
Ya luego podría usar ese comando para hacer otras cosas: parsear el valor y podría enviarme un correo avisándome que ya se me va a acabar la pila, o mandar un mensaje al systray o quizás conectarme al IRC y avisarle a mi nick al respecto; hay muchas cosas más que Perl nos facilita hacer, ¡tu imaginación es el límite!

De otras muchas formas habríamos podido abrir el archivo y leer el contenido de <code>charge</code> y <code>max_charge</code>. ¿Tú de qué forma lo hubieras hecho? ¿Quizás ciclar el filehandle hasta toparse con <code>/^max_charge/</code>? ¿Quizás usar alguna combinación con ejecución externa de <code>cat</code> o de <code>grep</code>?

Te invito a que me envíes tus comentarios. Nos leemos dentro de quince días.
</p>
<h3>
<a title="referencias_      tiles" name="referencias_%20%20%20%20%20%20tiles" id="referencias_      tiles"></a>Referencias útiles</h3>
<ul>
<li><a href="http://perldoc.perl.org/index-pragmas.html"><a href="http://perldoc.perl.org/index-pragmas.html">http://perldoc.perl.org/index-pragmas.html</a></a></li>
<li><a href="http://perldoc.perl.org/perlvar.html"><a href="http://perldoc.perl.org/perlvar.html">http://perldoc.perl.org/perlvar.html</a></a></li>
<li><a href="http://perldoc.perl.org/functions/int.html"><a href="http://perldoc.perl.org/functions/int.html">http://perldoc.perl.org/functions/int.html</a></a></li>
<li><a href="http://perldoc.perl.org/perlop.html#Integer-Arithmetic-integer"><a href="http://perldoc.perl.org/perlop.html#Integer-Arithmetic-integer">http://perldoc.perl.org/perlop.html#Integer-Arithmetic-integer</a></a></li>
</ul>
<h2>
<a title="autor" name="autor" id="autor"></a>Autor</h2>
<p>
Durante el día, David Moreno Garza (<a href="http://www.damog.net//"><a href="http://www.damog.net/">http://www.damog.net/</a></a>) desarrolla aplicaciones, sistemas y proyectos para una incipiente empresa internacional de telecomunicaciones; adicionalmente es consultor independiente en empresas mexicanas y extranjeras utilizando Perl. Durante la noche intenta salvar al mundo del mal usando expresiones regulares y <em>netiquette</em>.
</p>
<h2>
<a title="licencia_de_uso" name="licencia_de_uso" id="licencia_de_uso"></a>Licencia de uso</h2>
<p>
Copyright © 2007 David Moreno Garza.

This material may be distributed only subject to the terms and conditions set forth in the Open Publication License, v1.0 or later (the latest version is presently available at <a href="http://www.opencontent.org/openpub/"><a href="http://www.opencontent.org/openpub/">http://www.opencontent.org/openpub/</a></a>).

</p>
<hr>
<h1>
<a title="sobre_la_columna_pl" name="sobre_la_columna_pl" id="sobre_la_columna_pl"></a>Sobre <em>La <strong>Columna</strong>.<strong>pl</strong></em>
</h1>
<em>La <strong>Columna</strong>.<strong>pl</strong></em><p> es una columna quincenal que escribe el autor alrededor de Perl. Está inspirado en las columnas que Randal L. Schwartz ha escrito desde hace varios años ya. Por medio de recetas, consejos, instructivos y guías, el autor pretende propiciar interés en la gente para que conozca un poco más a fondo este apasionante lenguaje de programación y así fomentar una comunidad más sólida alrededor de él.

Visite <a href="http://www.damog.net/columnapl"><a href="http://www.damog.net/columnapl">http://www.damog.net/columnapl</a></a>. </p>
