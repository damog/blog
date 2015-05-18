Title: Automatización en web con WWW::Mechanize
Date: 2007-09-05 21:16:25
Tags: 

<a title="__index__" name="__index__" id="__index__"></a><ul>
<li>
<a href="#la_columna_pl__4">La Columna.pl #4</a>
<ul>
<li>
<a href="#automatizaci%EF%BF%BD_n_en_web_con_www__mechanize">Automatización en web con WWW::Mechanize</a>
<ul>
<li><a href="#introducci%EF%BF%BD_n">Introducción</a></li>
<li><a href="#script">Script</a></li>
<li><a href="#fin">Fin</a></li>
<li><a href="#referencias_%EF%BF%BD_tiles">Referencias Útiles</a></li>
</ul>
</li>
<li><a href="#autor">Autor</a></li>
<li><a href="#licencia_de_uso">Licencia de uso</a></li>
</ul>
</li>
<li><a href="#sobre_la_columna_pl">Sobre <em>La Columna.pl</em></a></li>
</ul>
<hr>
<h1>
<a title="la_columna_pl__4" name="la_columna_pl__4" id="la_columna_pl__4"></a>La Columna.pl #4</h1>
<h2>
<a title="automatizaci�_n_en_web_con_www__mechanize" name="automatizaci%EF%BF%BD_n_en_web_con_www__mechanize" id="automatizaci�_n_en_web_con_www__mechanize"></a>Automatización en web con WWW::Mechanize</h2>
<h3>
<a title="introducci�_n" name="introducci%EF%BF%BD_n" id="introducci�_n"></a>Introducción</h3>
<code>WWW::Mechanize</code><p> es un módulo muy interesante. Básicamente nos permite automatizar o mecanizar una conversación a través de una página web. Es decir, poder automatizar el procesamiento de enlaces, imágenes, formas, etc. En realidad <code>WWW::Mechanize</code> actúa como una subclase de <code>LWP::UserAgent</code>, que es el mítico LWP en Perl.

Hay que entender que todo lo que hacemos en un navegador web, o casi todo, es posible automatizarlo por medio de scripts, debido a que lo que en realidad sucede es que trabajamos con cabeceras y cuerpo <code>HTTP</code>, tanto en petición como en respuesta. Todo es a través del protocolo <code>HTTP</code>.

Mi trabajo actual requiere mucha interacción automatizada con páginas web y <code>WWW::Mechanize</code> me ha permitido hacer desarrollos muchos más rápidos, mucho mejor encapsulados y con un nivel de abstracción menor.

En esta cuarta columna, quiero hacer algo para mostrar de qué es capaz <code>WWW::Mechanize</code> y que ustedes, amables lectores, vean su utilidad real. Lo que haré será un proceso de autenticación en el wiki del proyecto Debian y la obtención de una de sus páginas. Básicamente es loguearme en el wiki y obtener el valor de uno de los campos de una forma. Lo interesante en este asunto viene al automatizar el login en un sistema basado en web, escribir en una forma y enviar forma, obtener campos, etc: <code>WWW::Mechanize</code> lo hace muy simple.

Manos a la obra.
</p>
<h3>
<a title="script" name="script" id="script"></a>Script</h3>
<p>
Vamos a empezar por invocar a nuestro intérprete de Perl activando warnings, así como el pragma <code>strict</code>.
</p>
<pre>
 #!/usr/bin/perl -w

 use strict;</pre>
<p>
Como necesitaremos un nombre de usuario y contraseña para acceder el wiki en Debian (es necesario para editar páginas), vamos a tomarlos como argumentos:
</p>
<pre>
 my $username = $ARGV[0] || die "ERR: Es necesario especificar un nombre de usuario", "\n";

 my $password = $ARGV[1] || die "ERR: Es necesario especificiar una contraseña", "\n";</pre>
<p>
Los argumentos vienen en el arreglo <code>@ARGV</code>: El primer argumento de nuestro programa será el nombre de usuario y el segundo será la contraseña. Si no existen, entonces nuestro programa morirá.

A continuación llamamos al módulo <code>WWW::Mechanize</code> y creamos un objeto de ese tipo.
</p>
<pre>
 use WWW::Mechanize;

 my $mech = WWW::Mechanize-&gt;new;</pre>
<p>
Bastante simple.

Ahora tenemos que ver qué es lo que haríamos desde un navegador convencional para hacer lo que queremos. Lo más lógico es que entráramos a la página del wiki de Debian, cuya URL es <a href="http://wiki.debian.org/"><a href="http://wiki.debian.org/">http://wiki.debian.org/</a></a>. Vamos a hacerlo de la misma manera en el script.
</p>
<pre>
 $mech-&gt;get('<a href="http://wiki.debian.org/"><a href="http://wiki.debian.org/">http://wiki.debian.org/</a></a>');

 unless($mech-&gt;success) {

  die "Tuvimos problemas al acceder la página de Debian", "\n";

 }</pre>
<p>
Básicamente estamos utilizando dos métodos disponibles en Mechanize: <code>get()</code> y <code>success()</code>. El primero hará que nuestro objeto viaje hasta la página que le indiquemos. En cualquier caso, el método <code>success()</code> nos indica por medio de un valor booleano si la última operación que se realizó en Mechanize, fue exitosa o algo falló, lo cual nos sirve para tener más control del flujo de nuestra aplicación. Si no tenemos problemas con <code>get()</code>, entonces el programa no morirá con el mensaje especificado; sin embargo si sí hubo problema, es decir, <code>success()</code> regresa falso, entonces entrará en acción el <code>die()</code>. Continuemos.

Una vez que estamos en Firefox (u Opera, o Internet Explorer, no sé) en la página <a href="http://wiki.debian.org/,"><a href="http://wiki.debian.org/,">http://wiki.debian.org/,</a></a> ¿qué es lo siguiente? Bueno, lo normal, que es al no estar logueados, nos aparezca un link que dice &#8220;Login&#8221;. En un proceso común tendríamos que dar clic en él para continuar con el proceso de autenticación. Eso mismo haremos:
</p>
<pre>
 $mech-&gt;follow_link(text =&gt; 'Login') or die "ERR: No pude dar clic en login", "\n";</pre>
<p>
Así de simple. Con el método <code>follow_link()</code> y el parámetro &#8216;text&#8217;, podemos indicarle a Mechanize que donde estamos actualmente, que sería la página frontal del wiki, siga el enlace cuyo texto es &#8216;Login&#8217;. Mechanize nos permite incluso acomodar regex en estos campos, lo cual nos facilitaría aún más al lidiar con contenido dinámico o situaciones más complejas. Como <code>follow_link()</code> regresa realmente un objeto <code>HTTP::Response</code> en caso de éxito, también provee un retorno en caso de falla, que es <code>undef</code>. Así que si hubo una falla al intentar seguir el enlace, moriremos con el mensaje de error especificado.

Una vez que dimos clic en &#8216;Login&#8217;, podemos ver en nuestro navegador convencional que la página donde nos encontramos es aquella con la URL &#8216;<a href="http://wiki.debian.org/UserPreferences"><a href="http://wiki.debian.org/UserPreferences">http://wiki.debian.org/UserPreferences</a></a>&#8217;. En realidad pudimos habernos evitado algo de código al empezar nuestro primer <code>get()</code> con esta URL pero intentaba mostrar un poco de las bondades de Mechanize. ¿Qué tal si en tu script no sabes en qué URL se encuentra tu navegador de Mechanize? Puedes usar el método <code>uri()</code> e incluso el método <code>response()</code>. Eso te ayudará a analizar bien el flujo de tu programa.

En fin, en esa página de UserPreferences podemos ver que tenemos una forma para introducir &#8220;Name&#8221;, &#8220;Password&#8221;, etc. En realidad esos dos campos son los que realmente nos interesan. Para ésto, nos puede servir mucho la extensión WebDeveloper de Firefox, pues con ella podemos ver la información detallada de las formas en las páginas. Lo que queremos saber es cuál es nombre de la forma para ingresar el nombre de usuario y la contraseña, y además, el nombre de estos dos campos (hay que recordar que comúnmente las formas en HTML llevan un parámetro &#8220;name&#8221;). O incluso puedes intentar buscar estos parámetros viendo el código HTML directo desde la página.

Luego de ver el HTML (o de usar la extensión de Firefox) nos damos cuenta que en la página de autenticación de Debian hay tres formas, sin embargo, la forma donde se introducen el nombre de usuario y la contraseña, ¡no tiene nombre! Mechanize sabe que algunos webmasters no colocan esta información, así que provee otra forma en que puedes usar esas formas: Por número. Puedes especificar si trabajarás con la primera, segunda, tercera o enésima forma. En nuestro ejemplo, la forma de autenticación es la tercera:
</p>
<pre> eval {

  $mech-&gt;form(3);

  $mech-&gt;submit_form('username' =&gt; $username, 'password' =&gt; $password);

 };</pre>
<pre>
 die "ERR: Problemas al enviar la forma: $@", "\n" if $@;</pre>
<p>
Un bonito pedazo de código aquí. Lo primero que notamos es que usamos un bloque <code>eval{}</code> para encapsular dos métodos, <code>form()</code> y <code>submit_form()</code>. <code>form()</code> selecciona la forma con la que trabajaremos, en este caso la tercera y <code>submit_form()</code> envía esa forma con los campos indicados. Es bastante intuitivo, ¿no crees? Y ya, básicamente eso es lo único que necesitamos para autenticarnos. En caso de falla con <code>submit_form()</code>, la aplicación muere, sin embargo, eso lo intentamos evitar usando <code>eval{}</code>. Si algo dentro del bloque de eval fallara y muriera, <code>eval{}</code> llena una variable especial, <code>$@</code> con el mensaje de error y ya después nosotros podemos morir o hacer lo que queramos. Bonito, ¿no es así?

Una vez que mandamos la forma, tenemos que asegurarnos que no nos haya mandado mensaje de password erróneo o algo así. Una cosa es que el envío de la forma con sus parámetros sea exitoso o no, y otra diferente que la información de usuario y contraseña sean incorrectos. ¿Cómo saber lo que necesitamos para identificar ésto? Podemos intentar en nuestro Firefox poniendo información errónea en estos campos e intentar loguearse. Al hacer pruebas de este tipo veo que es diferente si el usuario no existe o si la contraseña es errónea.

Si el usuario no existe, la página nos manda un error que dice: &#8220;Unknown user name: &#8221;sdfsdfsdf&#8220;. Please enter user name and password.&#8221;. Si la contraseña está mal (o sea, el usuario existe, pero la contraseña es errónea), la página despliega: &#8220;Sorry, wrong password.&#8221;. Vamos a ver cómo controlaríamos dichos mensajes:
</p>
<pre>
 die "Unknown user name!", "\n" if $mech-&gt;content =~ /Unknown user name/;

 die "Wrong password!", "\n" if $mech-&gt;content =~ /Sorry, wrong password/;</pre>
<p>
¡Qué sencillo! Morimos en caso de que el método <code>content()</code>, que nos regresa la cadena con todo el HTML de la página actual, contiene alguna de ambas cadenas. Código simple para regexs simples. Si no tenemos ninguno de ambos, asumimos que estaremos ya bien logueados.

Ahora, ¿qué es lo que queremos hacer? Digamos que queremos obtener lo que nuestra propia página tiene escrito. Las páginas de los usuarios son simples páginas del wiki con nuestro nombre de usuario, en mi caso, &#8220;http://wiki.debian.org/DavidMorenoGarza&#8221;, o lo que es lo mismo &#8220;<code><a href="http://wiki.debian.org/%24username">http://wiki.debian.org/$username</a></code>&#8221;:
</p>
<pre>
 $mech-&gt;get("<a href="http://wiki.debian.org/"><a href="http://wiki.debian.org/">http://wiki.debian.org/</a></a>$username");</pre>
<p>
Estando en dicha página hay en enlace que dice &#8220;Edit&#8221;, ese es en el que tendríamos que dar clic para entrar a la forma directa de nuestra página:
</p>
<pre>
 $mech-&gt;follow_link(text =&gt; 'Edit');</pre>
<p>
Y una vez en la página de edición, nos encontramos con una forma nuevamente, que es básicamente la caja de edición de la página. Al leer el HTML o usando WebDeveloper, nos encontramos con que la forma sí tiene nombre y la caja con el texto de la página se encuentra en un campo llamado &#8220;editor-textarea&#8221;. Pues vamos a obtener ese texto:
</p>
<pre>
 $mech-&gt;form_name('editor');

 my $pagetext = $mech-&gt;value("editor-textarea");</pre>
<p>
Con eso seleccionamos la forma cuyo nombre es &#8220;editor&#8221; y con <code>value()</code>, seleccionamos el valor de &#8220;editor-textarea&#8221; y lo guardamos en la variable $pagetext.

¿Qué más podemos hacer? Lo que queramos, quizás queremos usar ese valor y escribirlo en un archivo, modificarlo y volverlo a guardar, obtener el preview luego de modificarlo, etc, etc. En realidad desde aquí la imaginación es el límite.
</p>
<h3>
<a title="fin" name="fin" id="fin"></a>Fin</h3>
<p>
Una regla de oro que he aprendido luego de usar mucho WWW::Mechanize es que casi todo lo que puedas hacer en un navegador convencional, lo puedes hacer también con este módulo. No, no puedes interpretar JavaScript, pero muchas veces no lo necesitas si saber leer bien el HTML de una página y entiendes lo que estás realmente haciendo. A final de cuentas si entiendes perfectamente lo que pasa en una conversación por HTTP quizás ni siquiera necesites Mechanize, pues como un amigo me comentaba, Mechanize es simplemente una rompecabezas armado de muchos módulos alrededor de LWP.

Hazme llegar tus preguntas o comentarios a mi correo, <code>damog@espiral.org.mx</code>. Estaré encantado de saber qué usos le das a Mechanize.
</p>
<h3>
<a title="referencias_�_tiles" name="referencias_%EF%BF%BD_tiles" id="referencias_�_tiles"></a>Referencias Útiles</h3>
<ul>
<li><a href="http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize.pm"><a href="http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize.pm">http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize.pm</a></a></li>
<li><a href="http://search.cpan.org/~gaas/libwww-perl-5.808/lib/LWP/UserAgent.pm"><a href="http://search.cpan.org/~gaas/libwww-perl-5.808/lib/LWP/UserAgent.pm">http://search.cpan.org/~gaas/libwww-perl-5.808/lib/LWP/UserAgent.pm</a></a></li>
<li><a href="http://wiki.debian.org/"><a href="http://wiki.debian.org/">http://wiki.debian.org/</a></a></li>
<li><a href="http://wiki.debian.org/UserPreferences"><a href="http://wiki.debian.org/UserPreferences">http://wiki.debian.org/UserPreferences</a></a></li>
<li><a href="http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize/Examples.pod"><a href="http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize/Examples.pod">http://search.cpan.org/~petdance/WWW-Mechanize-1.30/lib/WWW/Mechanize/Examples.pod</a></a></li>
</ul>
<h2>
<a title="autor" name="autor" id="autor"></a>Autor</h2>
<p>
Durante el día, David Moreno Garza (<a href="http://www.damog.net/"><a href="http://www.damog.net/">http://www.damog.net/</a></a>) desarrolla aplicaciones, sistemas y proyectos para una incipiente empresa norteamericana;; adicionalmente es consultor independiente en empresas mexicanas y extranjeras utilizando Perl. Durante la noche intenta salvar al mundo del mal usando expresiones regulares y <em>netiquette</em>.
</p>
<h2>
<a title="licencia_de_uso" name="licencia_de_uso" id="licencia_de_uso"></a>Licencia de uso</h2>
<p>
Copyright © 2007 David Moreno Garza.

This material may be distributed only subject to the terms and conditions set forth in the Open Publication License, v1.0 or later (the latest version is presently available at <a href="http://www.opencontent.org/openpub/"><a href="http://www.opencontent.org/openpub/">http://www.opencontent.org/openpub/</a></a>).

</p>
<hr>
<h1>
<a title="sobre_la_columna_pl" name="sobre_la_columna_pl" id="sobre_la_columna_pl"></a>Sobre <em>La Columna.pl</em>
</h1>
<em>La Columna.pl</em><p> es una columna quincenal que escribe el autor alrededor de Perl. Está inspirada en las columnas que Randal L. Schwartz ha escrito desde hace varios años. Por medio de recetas, consejos, instructivos y guías, el autor pretende propiciar interés en la gente para que conozca un poco más a fondo este apasionante lenguaje de programación y así fomentar una comunidad más sólida alrededor de él.

Visite <a href="http://www.damog.net/la-columnapl"><a href="http://www.damog.net/la-columnapl">http://www.damog.net/la-columnapl</a></a>. </p>
