Title: Audio en archivos de video 3GP
Date: 2006-08-20 20:02:31
Tags: 
---
<p>Recientemente me ha dado por grabar algunos videos desde mi celular. Luego de echar a andar el bluetooth en la laptop, pasar fotos, música y videos desde el celular se hizo muy facilito. El problema fue que el <a target="_blank" href="http://chocolate.lgmobile.com">LG Chocolate</a> graba los videos en un formato <a target="_blank" href="http://en.wikipedia.org/wiki/3GP">3GP</a>, que <em>mplayer</em>, por ejemplo, sí puede reproducir, pero sin audio.

Googleando un poco y metiéndome a la lista de correos de mplayer, encontré que hay que recompilar mplayer agregando el códec AMR. Siempre me ha molestado recompilar. No recompilo ni siquiera mi kernel, me ladilla tremendamente. Además, Debian tiene facilidades muy sencillas para construir módulos a partir de los headers que te puedes bajar en forma de paquetes. Entonces generalmente las cosas que trae el kernel empaquetado en stock de Debian, al menos en powerpc, satisface muchas de las actuales necesidades, sobre todo en el kernel 2.6.17. Pero bueno, el kernel no era el punto. El punto es que hay que recompilar mplayer.

Estos celulares de 3G utilizan precisamente el códec AMR, Adaptive Multi-Rate, el cual está disponible gratuitamente para uso personal, desde el sitio de <a target="_blank" href="http://www.3gpp.org">3GPP</a>. Para todo esto, utilizo el paquete de mplayer de A Menucc1, DD, pues tiene el QA requerido por Debian, aún cuando no está oficialmente en el archivo de Debian y su versión para Etch es altamente estable.

Cito la <a target="_blank" href="http://www.mplayerhq.hu/DOCS/HTML/en/audio-codecs.html">página de códecs</a> de <em>mplayer</em>:
</p>
<blockquote>To enable support, download the sources for <a target="_top" href="http://www.3gpp.org/ftp/Specs/latest/Rel-6/26_series/26104-610.zip">AMR-NB</a> and <a target="_top" href="http://www.3gpp.org/ftp/Specs/latest/Rel-6/26_series/26204-600.zip">AMR-WB</a> codecs, put them in the directory where you unpacked the MPlayer source and run the following commands:
<pre>unzip 26104-610.zip
unzip 26104-610_ANSI_C_source_code.zip
mv c-code libavcodec/amr_float
unzip 26204-600.zip
unzip 26204-600_ANSI-C_source_code.zip
mv c-code libavcodec/amrwb_float</pre>
After that, follow the usual MPlayer build procedure.</blockquote>
<p>
Bastante sencillo. En sistemas Debian, se pueden obtener los sources del paquete desde <a target="_blank" href="http://tonelli.sns.it/pub/mplayer/etch/"><a href="http://tonelli.sns.it/pub/mplayer/etch/">http://tonelli.sns.it/pub/mplayer/etch/</a></a> y se desempaqueta normalmente:
</p>
<blockquote>$ dpkg-source -x mplayer_1.0pre8-1.dsc</blockquote>
<p>
&#8230;teniendo ya, obviamente, el orig.tar.gz, el diff.gz y el dsc. Luego de aplicado el código adicional de 3GPP, basta con construir nuevamente el paquete. Recomiendo altamente utilizar el wrapper <em>pdebuild</em> de <em>pbuilder</em> para dicho fin, si no van a hacer un menjurgue extremo de paquetes y dependencias de compilación. Luego de construido el paquete, basta buscar el .deb resultante en <em>/var/cache/pbuilder/result</em>. Si a alguien más le interesa, el paquete de mplayer 1.0pre8-1 para powerpc, lo puse <a target="_blank" href="http://www.damog.net/files/misc/mplayer_1.0pre8-1_powerpc.deb">acá</a>.

Nota: Si por alguna razón <em>mplayer</em> falla al compilarse por no encontrar <em>/usr/lib/libxmms.so.1</em>, basta con que se agregue <em>xmms</em> como Build-Depends en el debian/control, o que hagan login al chroot de pbuilder y lo instalen manualmente, que fue lo que yo hice:
</p>
<blockquote>$ sudo pbuilder login &#8212;save-after-login
# apt-get install xmms</blockquote>
<p>
Ya teniendo el soporte de AMR, es posible convertir los 3GPs a formatos más amigables con mplayer usando mencoder, como AVI, y ver al <a target="_blank" href="http://www.damog.net/files/misc/wada-limosna.avi.zip">Wada pidiendo limosnas en el Poli</a> :-)
</p>
<blockquote></blockquote>
