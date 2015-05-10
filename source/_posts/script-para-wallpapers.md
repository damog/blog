Title: Script para wallpapers
Date: 2004-12-01 15:45:57
Tags: 
---
<p>Pues jugando un poco con GConf, me he hecho un mini scriptcito en Perl para cambiar los wallpapers cada 60 segundos, en GNOME.

Esta idea me surgió debido a que alguna vez vi que el <a href="http://blog.tacvbo.net/">Ta^3</a> tiene esta conducta en su XFCE4.

Quizás haya una forma más limpia de hacer ésto, pero bueno, al menos funciona, incluso lanzando el script como una aplicación al iniciar GNOME.

Lo único que necesitamos es, obviamente GConf.
</p>
<pre>#!/usr/bin/env perl

# Seamos estrictos con nuestro pedazo de código.
use strict;

# El lugar donde se encuentran nuestros wallpapers:
my $wallpath = '/home/damog/fondos';

# Lanzamos el comando para que nuestros wallpapers llenen la pantalla,
# lo cual creo que es la mejor conducta al poner los wallpapers.
`gconftool-2 -t str -s /desktop/gnome/background/picture_options stretched`;

# Empieza el ciclo infinito...
while(1) {
# Todo lo empaquetamos en la lista @files.
my @files = glob("$wallpath/*");

# Agarramos uno al azar.
my $fondo = $files[rand(scalar(@files))];

# Imprimimos información pertinente.
print 'Cambiando el fondo a ', $fondo, "...\n";
my ($sec, $min, $hor) = localtime(time);
print ' - a las ', "$hor:$min:$sec\n\n";

# Hacemos la magia ;-)
`gconftool-2 -t str -s /desktop/gnome/background/picture_filename $fondo`;

# Y nos echamos a dormir un minuto para luego volver a ciclar.
sleep 60;
}</pre>
<p>
No me maldigan, apenas estoy aprendiendo Perl :-) </p>
