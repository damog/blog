title: "Galaxia Linux"
Date: 2008-09-27 13:23:42
Tags: hack,idiotas,planeta linux
---
Hace unos cuantos días vi que un nuevo proyecto de blogueros sobre Linux estaba siendo formado, Galaxia Linux. Al formar parte del <a href="http://www.planetalinux.org/creditos.php">selecto grupo de administradores de Planeta Linux</a>, siempre nos interesa sumar esfuerzos: No nos gusta pensar que hay proyectos que lo único que quieren es aprovechar el trabajo de los demás sin crédito, me gusta pensar en <a href="http://planetalinux.org/">Planeta Linux</a> como un proyecto que puede ayudar a muchos otros más a formarse reforzando la comunidad latinoamericana linuxera, engordándola, consolidándola, sin embargo, bueno, ésto no es lo mismo en la dirección opuesta.

Me interesó mucho que Galaxia Linux intentara hacer un ranking hispanoamericano de blogs sobre Linux y quise saber cómo lo hacían. Me sorprendió que en su sitio, para "formar parte" había que colocar una simple y burda imagen en el sitio. ¿Así es como rankean a los sitios? Lo puse pues, en varias de las instancias de Planeta Linux y cada que recargaba el sitio, se le sumaba una hit más al contador en la página del ranking. ¿No es lo más burdo e ineficaz que se les ocurre? ¿Cómo lo estaban haciendo? Su banner es claramente un GIF generado por un script en PHP. Me lo imagino tan simple como que cada que se ejecuta, lee la variable HTTP_REFERER, si el sitio ya se encuentra en una base de datos, aumenta el contador, si no es así, crea un nuevo sitio en la tablita con el hit en 1. Y ya, ese es el ranking que intentan crear. Luego, en la página principal, pues simplemente ponen los sitios que tienen más hits, aparentemente "semanalmente". Es decir, si en el sexto día de la semana, un sitio con muchísimo tráfico "se une", básicamente se la pela porque el contador semanal ya contó hits para otros sitios durante seis días y un par de sitios puede que tengan más por los seis días que un verdadero sitio en uno solo. Jugando, puedes hacer ésto:

<code>
use LWP::UserAgent;
my $ua = LWP::UserAgent-&gt;new;
# Ternurita...
$ua-&gt;agent("Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)");
while(1) {
# Para ahorrar ancho de banda, hago HEAD, en lugar de GET
my $req = HTTP::Request-&gt;new(HEAD =&gt; 'http://www.galaxialinux.com/rank/banners/banner.php');
$req-&gt;referer('http://mx.planetalinux.org/');
my $res = $c-&gt;request($req);
# Gracias, vuelvas prontos.
}
</code>

Claro, ésto también pudo haber sido hecho mucho más rápido con <a href="http://linux.about.com/library/cmd/blcmdl1_lwp-request.htm">lwp-request</a>, por ejemplo, que hace precisamente lo mismo utilizando LWP. O <a href="http://log.damog.net/2008/09/galaxia-linux/">como dice MaoP en los comentarios</a>, claro, con wget.

¿Qué define un ranking? Rankear blogs o sitios web no es nada sencillo, no es nada más darles a los sitios una imagen para que la inserten, me gustaría saber qué opina por ejemplo, <a href="http://www.alianzo.com/">Alianzo</a> o <a href="http://bloglines.com">Bloglines</a>, o <a href="http://technorati.com">Technorati</a>, o <a href="http://google.com/reader">Google Reader</a>, de la forma en que Galaxia Linux rankea los sitios: No es algo sencillo, no es algo a la ligera. Corrí mi script desde varios lugares y luego de un ratito Planeta Linux México estaba en primer lugar (luego ya no estuvo, supongo que se dieron cuenta que mi ranking "subió" rápido en poco tiempo y le quitaron hits, este tipo de cosas tampoco debería tener intervención manual, quita la fiabilidad).

Invito a la gente de Galaxia Linux a que arreglen los problemas de fiabilidad y credibilidad que tienen en su sistema porque es una excelente idea, y nadie se las va a quitar o robar, si hacen bien las cosas y no se lo toman a la ligera.

<strong>UPDATE</strong>: "El sitio es beta" es uno de los pobres argumentos. Bueno, si realmente desean hacer un ranking fiable, la imagen que le ofrecen insertar a la gente está de más, ¿cuando no sea beta el sitio la imagen dejará de necesitarse? Debería, ¿no? Porque seguir haciendo un ranking basado en referers y hits... ¿dónde se ha visto eso? El objetivo es claro y bueno, la forma en que lo hacen no, todo su diseño de concepto está errado.
<strong>UPDATE</strong>: He cambiado el término que uso de visitas por hits, porque tiene más claridad y evita ambigüedad pues fueron páginas vistas, o hits, a lo que me referí todo el tiempo. Hasta un simio pudo haberlo entendido.
<strong>UPDATE</strong>: Las reacciones no se hicieron esperar, mi tocayo <a href="http://gnuget.org/blog/view/192/galaxialinux-y-como-no-reaccionar-como-un-perdedor">David Valdez lo cuenta mejor</a>.
<strong>UPDATE</strong>: Había optado por mantener despublicado esta entrada para evitar mayores confrontaciones y le había ofrecido una disculpa a la gente de Galaxia Linux por no haber escogido bien mis palabras desde el principio, pero dada su reacción y ataque, he decidido volver a publicar este post.