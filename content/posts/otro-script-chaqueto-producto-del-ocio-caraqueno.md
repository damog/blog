---
title: "Otro script chaqueto producto del ocio caraqueño"
date: 2006-03-09 18:44:13
tag: 
---
<p>Pues desde ayer empecé a jugar un poco con WWW::Mechanize, a sugerencia de <a target="_blank" href="http://bureado.unplug.org.ve">José</a>. Pretendía parsear las páginas de wallpapers de <a target="_blank" href="http://www.deviantart.com">DeviantArt</a> para obtener uno de ellos de la sección de favoritos para colocarlo como el background de <a target="_blank" href="http://www.gnome.org/">GNOME</a> en su llave de <a target="_blank" href="http://www.gnome.org/projects/gconf/">GConf</a>. Alguna vez había ya hecho algo similar, como se podrá recordar con <a target="_blank" href="http://www.damog.net/?p=373">Poxole</a> en diciembre de 2004. De cualquier forma, empecé a jugar un poco y a seguir jugando linduras con Perl. Terminé con un script que necesita los módulos <a target="_blank" href="http://search.cpan.org/dist/WWW-Mechanize/">WWW::Mechanize</a>, <a target="_blank" href="http://search.cpan.org/dist/libwww-perl/">LWP</a> y <a target="_blank" href="http://search.cpan.org/dist/Gnome2-GConf/">GNOME2::GConf</a>. Como José es medio chimbo/chundo, sugirió que se ejecutara system() lanzando gconftool-2, pero pos, como que no es muy elegante :P (Aunque otra veces me sorprende, como el hecho de querer registrar el nick de un eggdrop a través de su consola de Telnet en lugar de generarlo por separado y luego simplemente importar el password :-/).

Finalmente el script se tiene que correr sin argumentos. El script se conecta a <a target="_blank" href="http://wallpaper.deviantart.com"><a href="http://wallpaper.deviantart.com/">http://wallpaper.deviantart.com/</a></a>, entra a la sección de Today&#8217;s Favourites y toma uno de los 24 wallpapers que están ahí aleatoriamente, lo guarda en $HOME/.deviantart y apunta la llave /desktop/gnome/background/picture_filename hacia la ubicación de la imagen que bajó. Obviamente depende de la velocidad de conexión para que se ejecute rápidamente:
</p>
<pre>damog @ isabel ~/Desktop/perl/deviantart $ perl deviantart.pl
- Iniciando...
- Voy a bajar <a href="http://ic1.deviantart.com/fs9/i/2006/068/a/9/Eye_by_Lamia_Ell.jpg...">http://ic1.deviantart.com/fs9/i/2006/068/a/9/Eye_by_Lamia_Ell.jpg...</a>
- Guardando en /home/damog/.deviantart/Eye_by_Lamia_Ell.jpg... Listo.
Done!
damog @ isabel ~/Desktop/perl/deviantart $</pre>
<p>
El script está <a target="_blank" href="http://www.damog.net/files/misc/deviantart.perl.html">acá</a>, como <a target="_blank" href="http://en.wikipedia.org/wiki/Public_domain">dominio público</a>. Quizás le haga una ligera modificación más: Los wallpapers en DeviantArt se agrupan por categorías como <a target="_blank" href="http://wallpaper.deviantart.com/females">Females</a>, <a target="_blank" href="http://wallpaper.deviantart.com/fractals">Fractals</a>, <a target="_blank" href="http://wallpaper.deviantart.com/minimalist">Minimalist</a>, etc. Un flag como <code>--section=minimalist</code>, para que jale uno aleatorio de esa categoría sería el TODO para la siguiente versión :) </p>
