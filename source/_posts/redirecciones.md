Title: Redirecciones
Date: 2007-08-31 22:48:10
Tags: 
---
<h1>La Columna.pl #3</h1>
<h2>
<a title="redirecciones" name="redirecciones" id="redirecciones"></a>Redirecciones</h2>
<p>
Bueno, el ofrecer disculpas por tardanzas tan prolongadas en la entrega de esta columna, ya se está haciendo costumbre, ¡y apenas van tres columnas! Por ahora mejor tomaré otro <em>approach</em> para las próximas liberaciones de la misma: Se harán nuevas entregas cuando estén listas. Un enfoque plenamente debianero.

Como sea, durante el mes pasado estuve principalmente preparándome, asistiendo y recuperándome de la Debian Conference que se llevó a cabo en las tierras del whisky, Escocia (pueden ver fotografías en mi galería). Como éste era un viaje que había planeado con mucha antelación, cuando supe que el <code>YAPC::NA</code> se realizaría en Houston, no pude dejar de lamentarme semanas y semanas por que estaría destinado a no asistir. En fin, a ver qué tal el próximo año. Gracias a las personas que preguntaron sobre el paradero de ésta, su columna de confianza.

En fin.

En los últimos días estuve revisando un sitio que implementaba cosas interesantes. Entre ellas, una aplicación que hacía redirecciones en web. Éstas son algo populares, pero no muy conocidos: Una aplicacioncita web que nos permite crear URLs del tipo: <code><a href="http://www.midominio.com/cgi-bin/forward.cgi?url=damog.net">http://www.midominio.com/cgi-bin/forward.cgi?url=damog.net</a></code>. Básicamente, es un CGI que recibe un argumento y hace una redirección hacia ese sitio, ¿muy simple? Quizás sí, pero nosotros podemos agregarle mucha más funcionalidad muy interesante. Es cierto que dichas redirecciones pueden hacerse con <code>mod_rewrite</code> de Apache o similares, pero obviamente no le podemos agregar tanta flexibilidad y triques como con un script en Perl.

Lo que quiero, entonces, es un redireccionador que en primer lugar, verifique que la URL sea válida, quizá escribir en un log o una base de datos y haga la redirección. Además, utilizaremos un poco de rewrites para añadirle un poco de atractivo visual al asunto.

Empezaré a escribir el <code>redir.cgi</code>:
</p>
<pre> #!/usr/bin/perl

use strict;
use warnings;

use CGI qw(:standard);
use Data::Validate::URI qw(is_http_uri is_https_uri);

my $url = param('url') || '<a href="http://www.damog.net//"><a href="http://www.damog.net/">http://www.damog.net/</a></a>‘;
$url =~ s/^http(s?)://http$1:///;

&amp;wrong($url) unless is_http_uri($url) || is_https_uri($url);

# Más código…
# Quizás escribir a un log, etc..
print “Location: $url”, “\n\n”;

sub wrong {
my ($url) = shift;
print “Content-Type: text/plain”, “\n\n”;
print “It looks like $url is not a valid URL!”;
exit;
}</pre>
<p>
Es un código bastante corto y simple. Usamos un par de pragmas, un par de módulos, procesamos el parámetro que recibiremos, validamos y redireccionamos. Vamos por partes. Para poder realizar este ejemplo, necesitaremos tener habilitada la ejecución de CGIs en nuestro servidor web. Para más información al respecto, puedes revisar la información de Apache o Cherokee al respecto, la explicación de tal procedimiento está fuera de contexto en esta columna. Encuentra enlaces útiles más abajo, en la sección de <em>Referencias útiles</em>.
</p>
<pre> #!/usr/bin/perl

use strict;
use warnings;</pre>
<p>
Desde luego, nuestro CGI necesitará saber dónde encontrar el intérprete para la ejecución. Además, como buena práctica de programación, añadiremos los pragmas <code>strict</code> y <code>warnings</code>. Desde un personal punto de vista, una vez que nuestra aplicación en desarrollo haya quedado limpia de errores fatales o advertencias, podríamos deshabilitar ambos pragmas, los cuales podrían volverse a cargar cuando se haga <em>debugging</em> o algo similar; pero a final de cuentas es sólo un punto de vista personal que cada quién seguirá teniendo sus propias razones y necesidades.
</p>
<pre> use CGI qw(:standard);
use Data::Validate::URI qw (is_http_uri is_https_uri);</pre>
<p>
Utilizamos dos módulos. El primero es un módulo que pertenece a Perl y que nos permite un manejo muy sencillo de, claro, CGIs y todo alrededor de ellos. Nosotros realmente lo utilizamos para obtener el parámetro que se le mande al script, con la función <code>param()</code>, que de hecho puede recibir los parámetros tanto en HTTP GET o POST. También podríamos obtener dicho parámetro desde el hash <code>%ENV</code>, pero hay que hacer un poco más de talacha, así que mejor usaremos <code>CGI.pm</code> y listo.

<code>Data::Validate::URI</code> es un módulo que encontré en CPAN que hace mínimamente lo que necesitamos, validar URIs. Si una cadena es una URI de HTTP o HTTPS, se valida y regresará falso en dado que no lo sea. Eso es más que suficiente. La explicación sobre la instalación de módulos de CPAN queda fuera del contexto de esta columna.
</p>
<pre> my $url = param('url') || '<a href="http://www.damog.net//"><a href="http://www.damog.net/">http://www.damog.net/</a></a>‘;
$url =~ s/^http(s?):/{1,2}/http$1:///g;</pre>
<p>
Creamos la variable <code>$url</code> con el parámetro GET o POST que nos traen al CGI. En caso de que no exista dicho valor, colocaremos alguna otra cadena, en mi caso, mi sitio. La siguiente línea tiene un poco de truco. Resulta que me idea era procesar este script pasándolo por una regla de Rewrite de Apache. Sin embargo, cuando <code>mod_rewrite</code> recibe en la URL la cadena ‘http://’, la cambia, por seguridad y motivos similares, a ‘http:/’, entonces cuando estaba haciendo pruebas con este redireccionamiento, el script fallaba pues intentaba entrar a digamos, ‘http:/google.com’; entonces la segunda línea es un hack para este comportamiento. ¿Pero qué hace la expresión regular? Bueno, hace un <em>search and replace</em>, en la cadena busca aquello que empieza con ‘http’, después puede contener o no (es decir, cero o una vez) la ’s’ -y ésto a su vez lo cachamos con un paréntesis-, seguido de dos puntos y una diagonal, que puede estar una o dos veces. Todo eso lo cambiamos por ‘http’, el valor que cachamos en el paréntesis, <code>$1</code>, dos puntos y dos diagonales. Lo hacemos las veces que sea necesario implementando el modificador ‘g’. Entonces, si recibimos ‘https:/google.com’ lo cambiará a ‘https://google.com’; y si recibimos ‘http://www.damog.net’, lo cambiará a, exactamente lo mismo, ‘http://www.damog.net’.
</p>
<pre> &amp;wrong($url) unless is_http_uri($url) || is_https_uri($url);</pre>
<p>
Llamamos a la subrutina <code>wrong()</code>, pasándole la URL, a menos que sea una URI de HTTP o de HTTPS válida. <code>is_http_uri</code> e <code>is_https_uri</code> nos devolverán indefinido, en caso de que falle la validación y lanzarán <code>wrong</code>, que lo único que hace realmente es imprimir un error en el <em>browser</em>. Veremos la subrutina unas cuantas líneas abajo. Antes pudimos haber guardado en base de datos, utilizar la variable <code>$ENV{REMOTE_ADDR}</code> o muchas cosas, usted decida.
</p>
<pre> print "Location: $url", "\n\n";</pre>
<p>
Éste es un header que tenemos que colocar en la respuesta del cliente, para que el servidor tome la nueva URL y se haga una redirección. El usuario siempre debe recordar que los <em>headers</em> son colocados hasta cuando se encuentren dos nuevas líneas. De otra forma, nuestro servidor web local no definirá dónde acaban las cabeceras y no terminará la ejecución con error. Hasta este punto pasamos las validaciones y le aplicamos el <em>hack</em> para corregir el inconveniente con <code>mod_rewrite</code>. Desde luego que verificar si la URL es válida, es decir, que la URL nos lleve realmente a algún lado o página con contenido válido o que el servidor remoto esté efectivamente funcionando, está fuera del contexto de esta columna, nosotros simplemente cuando nos llega la petición tomamos la URL y colocamos un encabezado en nuestra respuesta en la comunicación HTTP. ¿Lindo, no? <img src="http://www.damog.net/wp-includes/images/smilies/icon_smile.gif" alt=":-)"/> Puedes usar algunos otros métodos para validar si la URL remota realmente es válida, quizás usando Net::Ping.

Ahora, veamos la subrutina <code>wrong</code>.
</p>
<pre> sub wrong {
my ($url) = shift;
print "Content-Type: text/plain", "\n\n";
print "It looks like $url is not a valid URL!";
exit;
}</pre>
<p>
Tomamos la variable <code>$url</code> con la URL que le pasamos. <code>shift</code> saca el primer elemento de un arreglo, en este caso <code>@_</code>. Y listo, imprimimos un mensaje en pantalla. Hay que colocar una cabecera <code>Content-Type</code>, dejar doble línea y ponemos el mensaje. Luego buscamos la puerta de salida y terminamos.

Hasta ahora es bastante simple y bien programado. Podemos probar la funcionalidad yendo hacia: <code><a href="http://www.damog.net/cgi-bin/redir.cgi?url=http://www.google.com">http://www.damog.net/cgi-bin/redir.cgi?url=http://www.google.com</a></code> o cualquier otra URL, inténtelo. Incluso podríamos poner una formita web, pues <code>param()</code> puede tomar, como ya lo decía argumentos POST o GET, indistintamente.

Como quiero empezar a usar este método para hacer ligas desde mi sitio a otros y quiero que tenga una mejor apariencia que esa URL larga y fea, hago uso de <code>mod_rewrite</code> y coloco un <code>.htaccess</code> en mi servidor web:
</p>
<pre> &lt;IfModule mod_rewrite.c&gt;
RewriteEngine On
RewriteRule ^-&gt;(.*)$ /cgi-bin/redir.cgi?url=$1 [L]
&lt;/IfModule&gt;</pre>
<p>
Con dicha regla lo que hago es que cuando reciba una URL con una flechita (`-&gt;’), tomaré lo que venga a continuación y lo consideraré una URL, que es lo que le pasaré al <code>redir.cgi</code>. Entonces, puedo llamar <a href="../-%3Ehttp://www.google.com"><a href="http://www.damog.net/-&gt;http://www.google.com">http://www.damog.net/-&gt;http://www.google.com</a></a> y hará lo que quiero que haga, la ejecución del CGI con la URL como parámetro, y con la flechita se ve muy intuitivo.

¿Qué tal implementar además, logs o escritura en base de datos, o algo así? Inténtalo, la imaginación es el límite. Me gustaría mucho leer sus comentarios.
</p>
<h3>
<a title="referencias_   tiles" name="referencias_%20%20%20tiles" id="referencias_   tiles"></a>Referencias útiles</h3>
<ul>
<li><a href="http://httpd.apache.org/docs/2.0/howto/cgi.html"><a href="http://httpd.apache.org/docs/2.0/howto/cgi.html">http://httpd.apache.org/docs/2.0/howto/cgi.html</a></a></li>
<li><a href="http://www.cherokee-project.com/doc/CGI_executing.html"><a href="http://www.cherokee-project.com/doc/CGI_executing.html">http://www.cherokee-project.com/doc/CGI_executing.html</a></a></li>
<li><a href="http://search.cpan.org/%7Esonnen/Data-Validate-URI-0.01/lib/Data/Validate/URI.pm"><a href="http://search.cpan.org/~sonnen/Data-Validate-URI-0.01/lib/Data/Validate/URI.pm">http://search.cpan.org/~sonnen/Data-Validate-URI-0.01/lib/Data/Validate/URI.pm</a></a></li>
<li><a href="http://search.cpan.org/%7Ebbb/Net-Ping-2.31/lib/Net/Ping.pm"><a href="http://search.cpan.org/~bbb/Net-Ping-2.31/lib/Net/Ping.pm">http://search.cpan.org/~bbb/Net-Ping-2.31/lib/Net/Ping.pm</a></a></li>
<li><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html</a></a></li>
<li><a href="http://httpd.apache.org/docs/2.0/mod/mod_rewrite.html"><a href="http://httpd.apache.org/docs/2.0/mod/mod_rewrite.html">http://httpd.apache.org/docs/2.0/mod/mod_rewrite.html</a></a></li>
<li><a href="http://www.damog.net/gallery/v/edinburgh"><a href="http://www.damog.net/gallery/v/edinburgh">http://www.damog.net/gallery/v/edinburgh</a></a></li>
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
<a title="sobre_la_columna_pl" name="sobre_la_columna_pl" id="sobre_la_columna_pl"></a>Sobre <em>La Columna.pl</em>
</h1>
<em>La Columna.pl</em><p> es una columna quincenal que escribe el autor alrededor de Perl. Está inspirado en las columnas que Randal L. Schwartz ha escrito desde hace varios años ya. Por medio de recetas, consejos, instructivos y guías, el autor pretende propiciar interés en la gente para que conozca un poco más a fondo este apasionante lenguaje de programación y así fomentar una comunidad más sólida alrededor de él.

Visite <a href="http://www.damog.net/columnapl"><a href="http://www.damog.net/columnapl">http://www.damog.net/columnapl</a></a>. </p>
