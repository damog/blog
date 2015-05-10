title: "Tips para Fluxbox"
Date: 2006-07-24 22:26:32
Tags: 
---
<p>Bueno, desde hace unos meses he intentado escribir algunos tips que he ido descubriendo al utilizar Fluxbox durante hace ya mucho tiempo, precisamente para los cuates que me han comentado o que he leído que han empezado a utilizar Fluxbox, especialmente a <a target="_blank" href="http://mannyto.unplug.org.mve">mannyto</a>, <a target="_blank" href="http://ghostbar.ath.cx/">ghostbar</a> y <a target="_blank" href="http://www.riveonline.com/">RIVE</a>, y en general para cualquier otro mai que quiera empezar a usar este fantástico manejador de ventanas.
<br/>Lanzar tus aplicaciones cuando inicia Fluxbox
Dentro del directorio .fluxbox/, se encuentra un archivo apps. Este archivo sirve precisamente para definir algunos arreglos de control, entre ellos startup. Para lanzar los comandos que quieras, bastará con que pongas una línea más o menos así:
</p>
<blockquote>[startup] {gkrellm -w &amp; wmblob &amp; wmbiff}</blockquote>
<p>
En este caso, lanzo gkrellm, wmblob y wmbiff al mismo tiempo. Si lo haces con doble ampersand, tendrías que cerrar la primera aplicación para que diera paso al nuevo proceso, lo cual no queremos. Al poner un sólo ampersand lanza todos los comandos al mismo tiempo y se cargan como procesos separados.

Que tus aplicaciones de GTK tengan el mismo look and feel del theme de GNOME.
Coloca un script llamado gnome.sh dentro del directorio .fluxbox/ que contenga algo así:
</p>
<blockquote>#!/bin/sh

GSD_PATH=/usr/bin
if [ -e $GSD_PATH/gnome-settings-daemon ]; then
GSDPID=`pidof gnome-settings-daemon`
if [ -z $GSDPID ]; then
exec $GSD_PATH/gnome-settings-daemon &amp;
else
echo &#8220;Error: Gnome Settings Daemon already running!&#8221;
fi
else
echo &#8220;Error: $GSD_PATH/gnome-settings-daemon is not found!&#8221;
fi</blockquote>
<p>
Luego bastará con que le des permisos de ejecución al script y lo añadas a tu arreglo startup de .fluxbox/apps:
</p>
<blockquote>[startup] {~/.fluxbox/gnome.sh &amp; gkrellm -w &amp; wmblob &amp; wmbiff}</blockquote>
<p>
Tus ventanas ahora tomarán el mismo theme de GNOME.

Controlar los escritorios de la misma forma que en GNOME.
Algo que a mí me gustaba mucho de GNOME es la facilidad para cambiar entre escritorios presionando la combinación de teclas Ctrl + Alt + flecha izquierda o derecha. Para hacerlo de la misma forma, bastará con que edites el .fluxbox/keys y coloques las siguientes líneas:
</p>
<blockquote>Mod1 Control Right :NextWorkspace
Mod1 Control Left :PrevWorkspace</blockquote>Cerrar ventanas con Alt + F4.<p>
Puedes cerrar las ventanas oprimiendo Alt + F4 como en la mayoría de los manejadores de ventanas (y en otros sistemas operativos :-)) colocando esto en tu .fluxbox/keys:
</p>
<blockquote>Mod1 F4 :Close</blockquote>Obtener el menú principal de Fluxbox con una combinación de teclas.<p>
Para obtener el menú principal de Fluxbox sin tener que dar clic izquierdo con el mouse en el área del background, basta con agregar algo así en el .fluxbox/keys:
</p>
<blockquote>Mod1 Return :RootMenu</blockquote>
<p>
De esa forma podrás sacar el menú oprimiendo Alt + Enter.

Mantener una imagen de wallpaper que se siga colocando incluso al reiniciar Fluxbox.
Basta con editar el .fluxbox/init y colocar el valor de la directriz session.screen0.rootCommand, que en mi caso es:
</p>
<blockquote>session.screen0.rootCommand:    feh &#8212;bg-seamless /home/damog/Desktop/imagenes/f]ondos/debian1600.png</blockquote>Utilizar un menú de diálogo para lanzar aplicaciones.<p>
Puedes utilizar fbrun para eso. Bastará con añadir una línea [exec] más al .fluxbox/menu más o menos así:
</p>
<blockquote>[exec] (Correr&#8230;) {/usr/bin/fbrun}</blockquote>
<p>
El comando fbrun viene en el mismo paquete distribuido oficialmente por Debian.

Usando el slit.
Poca gente conoce la utilidad del Slit de Fluxbox. El Slit es simplemente una piscina para los dockapps. Para lanzar tus dockapps y tenerlos agregados en el Slit, hace falta echar un vistazo hacia la directriz session.slitlistFile de .fluxbox/init, que en mi caso apunta a:
</p>
<blockquote>session.slitlistFile:   ~/.fluxbox/slitlist</blockquote>
<p>
Asimismo, dicho archivo únicamente contiene el orden que los dockapps tendrán. El primero siempre irá a la derecha o en la parte superior en el Slit y así sucesivamente hasta el último. En mi caso:
</p>
<blockquote>gkrellm
wmmoonclock
wmbubble
wmblob
wmbiff
wmcliphist
wmMand
wmmand</blockquote>
<p>
Nótese que quizás no todos estos dockapps se vean, porque este es sólo el orden en que se desplegarán en el Slit. Para lanzarlos, es necesario que eches un ojo a tu .fluxbox/apps.

Colocando la hora en un formato más agradable.
Me molestaba mucho que la hora desplegada en la Toolbar fuera tan poco descriptiva. Para cambiarla, hace falta conocer un poco el formato de strftime y lo podemos colocar en la directriz session.screen0.strftimeFormat de .fluxbox/init, que en mi caso tengo:
</p>
<blockquote>session.screen0.strftimeFormat: %a, %b %d %Y - %T</blockquote>
<p>
De esa forma, la fecha que despliega la Toolbar es algo así:
</p>
<blockquote>Mon, Jul 24&#160;2006 - 16:54:24</blockquote>Haciendo transparente nuestro Toolbar.<p>
En la parte izquierda de la Toolbar, donde indica el nombre del escritorio, da clic derecho y coloca el mouse sobre la opción Alpha. Moviendo la rueda del mouse hacia arriba o hacia abajo, hará que la Toolbar se haga más o menos opaca, lo que te dará la transparencia que te guste :-) También puedes colocar un valor en la directriz session.screen0.toolbar.alpha de tu .fluxbox/init.

Cambiando entre tabs fácilmente.
No mucha gente conoce la capacidad de Fluxbox para agrupar ventanas de las aplicaciones en una sola y formar tabs (pestañas). En una misma ventana puedes llegar a tener una pestaña de Firefox, una de gEdit, de Evolution, etc, etc. Para crear las pestañas, bastará con que selecciones la barra de título de una aplicación, le des clic con el botón central y la arrastres hasta otra ventana de tu segunda aplicación. Fluxbox fusionará ambas ventanas y te creará una sola con pestañas para cada una.

Para cambiar entre las pestañas (digámosle mejor tabs) basta volver a nuestro .fluxbox/keys. En mi caso lo tengo así:
</p>
<blockquote>Mod1 Shift Right :NextTab
Mod1 Shift Left :PrevTab</blockquote>
<p>
De esa forma puedo cambiar entre los tabs presionando Alt + Shift + flecha izquierda o derecha para navegar entre ellas.

Aplicar todos los cambios que hagas en la configuración de Fluxbox.
Cada que modifiques algún archivo de configuración de Fluxbox, no es necesario, desde luego, que reinicies X o algo similar. Puedes hacerlo fácilmente sólo reiniciando Fluxbox y con una combinación de teclas puedes hacerlo. En mi caso lo tengo así, en mi .fluxbox/keys:
</p>
<blockquote>Control Mod1 space :Restart</blockquote>
<p>
De esa forma tengo que oprimir Ctrl + Alt + barra espaciadora, para que Fluxbox se reinicie y tome los nuevos valores.

<strong>Eso es todo por ahora.</strong>
Creo que eso es todo por el momento. De esa forma he podido hacer que mi Fluxbox sea de lo más placentero para trabajar y que no ocupe tanta memoria como otros manejadores de ventanas. El manejo de las combinaciones de teclas es de lo mejor que jamás he usado y termina siendo un excelente aliado para tu workstation o desktop. </p>
