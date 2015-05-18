Title: OpenBSD 3.4 en Toshiba Tecra 8100
Date: 2003-12-09 19:22:43
Tags: 

Bueno, tratando de colaborar un poco con la documentación de OpenBSD en lo referente a mi computadora, quiero escribir un poco de mis aventuras y vivencias instalando el sistema operativo que hasta ahora me ha dejado un excelente sabor de boca.

Tengo que aclarar que no soy ningún gurú sobre esto. Todo lo que escribo son las experiencias de un novato instalando su primer sistema *BSD.

Aclarado lo anterior, procedamos.

Un par de características rápidas de mi máquina:
<li>Procesador Pentium III 795&#160;MHz (que por alguna extraña razón me lo detecta sólo a 392&#160;MHz).</li>
<li>256&#160;MB RAM.</li>
<li>20&#160;GB HD.

Pues bueno, el primer problema que tuve es que mi computadora no podía bootear el CD de OpenBSD, cosa similar ya me había pasado alguna vez curioseando con FreeBSD y NetBSD, con puro BSD, ni siquiera la vez que instalé BeOS me produjo esos problemas el booteo del CD. En fin, gracias al <a href="http://web.archive.org/web/20031226230140/http://www.mig-29.net/">MiG</a> aquella vez pudimos forzar el booteo del CD con el binario `smbinst&#8217; del <a href="http://web.archive.org/web/20031226230140/http://btmgr.sourceforge.net/">Smart BootManager</a>. Esta vez también lo ocupé, bajé el binario y se instaló sobre el MBR, todo desde Debian. Cabe aclarar que mi laptop no tiene floppy interno, y no cuento con uno externo, por eso se me complicó más; de tener el floppy hubiera sido <a href="http://web.archive.org/web/20031226230140/http://openbsd.org/faq/faq4.html#UnixFlop">bastante sencillo y rápido</a>.

En fin, comencé la instalación, la cual es bastante sencilla, muy amigable, además, el multipremiado <a href="http://web.archive.org/web/20031226230140/http://www.openbsd.org/faq/faq.html">FAQ</a> de OpenBSD está muy bien detallado, todo estupendamente escrito.

Previamente ya había realizado mis particiones para OpenBSD, Debian, Fedora (o Mandrake, o alguna otra distribución cucha :P) y Windows.
<pre># fdisk wd0
Disk: wd0       geometry: 2432/255/63 [39070080 Sectors]
Offset: 0       Signature: 0xAA55
Starting       Ending       LBA Info:
#: id    C   H  S -    C   H  S [       start:      size   ]
------------------------------------------------------------------------
*0: A6  203   1  1 -  972 254 63 [     3261258:    12369987 ] OpenBSD
1: 0B  973   0  1 - 1458 254 63 [    15631245:     7807590 ] Win95 FAT-32
2: 05 1459   0  1 - 2431 254 63 [    23438835:    15631245 ] Extended DOS
3: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
Offset: 23438835        Signature: 0xAA55
Starting       Ending       LBA Info:
#: id    C   H  S -    C   H  S [       start:      size   ]
------------------------------------------------------------------------
*0: 83 1459   1  1 - 2370 254 63 [    23438898:    14651217 ] Linux files*
1: 05 2371   0  1 - 2431 254 63 [    38090115:      979965 ] Extended DOS
2: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
3: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
Offset: 38090115        Signature: 0xAA55
Starting       Ending       LBA Info:
#: id    C   H  S -    C   H  S [       start:      size   ]
------------------------------------------------------------------------
0: 82 2371   1  1 - 2431 254 63 [    38090178:      979902 ] Linux swap
1: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
2: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
3: 00    0   0  0 -    0   0  0 [           0:           0 ] unused
#</pre>
Y mis `rebanadas&#8217; de la partición de OpenBSD quedaron así:
<pre># disklabel wd0
# using MBR partition 0: type A6 off 3261258 (0x31c34a) size 12369987 (0xbcc043)
# /dev/rwd0c:
type: ESDI
disk: ESDI/IDE disk
label: IC25N020ATCS04-0
flags:
bytes/sector: 512
sectors/track: 63
tracks/cylinder: 16
sectors/cylinder: 1008
cylinders: 16383
total sectors: 39070080
rpm: 3600
interleave: 1
trackskew: 0
cylinderskew: 0
headswitch: 0           # microseconds
track-to-track seek: 0  # microseconds
drivedata: 0

16 partitions:
#        size   offset    fstype   [fsize bsize   cpg]
a:   511686  3261258    4.2BSD     2048 16384   328   # (Cyl. 3235*- 3742)
b:   819504  3772944      swap                        # (Cyl. 3743 - 4555)
c: 39070080        0    unused        0     0         # (Cyl.    0 - 38759)
d:   368928  4592448    4.2BSD     2048 16384   328   # (Cyl. 4556 - 4921)
e:   245952  4961376    4.2BSD     2048 16384   244   # (Cyl. 4922 - 5165)
g:  6758640  5207328    4.2BSD     2048 16384   328   # (Cyl. 5166 - 11870)
h:  3665277 11965968    4.2BSD     2048 16384   328   # (Cyl. 11871 - 15507*)
i:  7807590 15631245     MSDOS                        # (Cyl. 15507*- 23252*)
j: 14651217 23438898    ext2fs                        # (Cyl. 23252*- 37787*)
k:   979902 38090178   unknown                        # (Cyl. 37787*- 38759)
#</pre>
Particioné de esa forma, debido a que el FAQ lo marca de esa manera, únicamente que le agregué tamaño a las rebanadas, para aprovechar toda la partición de Open. Los puntos de montaje quedaron así:
<pre># more /etc/fstab
/dev/wd0a / ffs rw 1 1
/dev/wd0h /home ffs rw,nodev,nosuid 1 2
/dev/wd0d /tmp ffs rw,nodev,nosuid 1 2
/dev/wd0g /usr ffs rw,nodev 1 2
/dev/wd0e /var ffs rw,nodev,nosuid 1 2
#</pre>
;-)

Quise poner toda la explicación sobre el disco duro debido a que toda la instalación es bastante sencilla, esa parte es lo único que nos produce muchos problemas a las personas que empezamos en el mundo BSD, pero una vez estudiando bien, es bastante agradable.

Todo lo demás de la instalación es bastante intuitivo y rápido. Todo lo demás jaló de pelos.

Generé mi configuración de X con xf86config y corre bastante bien XFree86&#160;4.3 con mi tarjeta de video (más abajo, pongo mi dmesg para ver más especificaciones).

Algo que me produjo una enorme sorpresa fue la forma en que OpenBSD maneja USB. Acá en el trabajo tengo un mouse Microsoft IntelliMouse USB, me decidí a configurarlo. Lo enchufé en el puerto y maravilla, jaló inmediatamente. Caray, eso sí es bonito ;-)

Otra cosa que me encantó fue ver cómo se levantó mi tarjeta de red inalámbrica, y lo mejor de todo, cosa que siempre busqué con el kernel por default de Debian, limpieza. El kernel vomitaba una cantidad enorme de errores con la tarjeta de red inalámbrica, y con OpenBSD es bastante limpio.

El sonido también fue automático. Instalé `xcdplayer&#8217; y `aumix&#8217; y pude escuchar un CD de música, para probar el sonido automáticamente.

Cabe decir que no estoy ocupando el sistema como servidor, es mi laptop, la estoy usando como workstation para un par de cosas en el trabajo y de proyectos personales, pero no como escritorio (aunque realizo muchas actividades también de escritorio: IRC, IM, audio, etc).

En fin&#8230; <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/xf86config-openbsd34-damog.txt?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">Acá</a> se puede encontrar mi XF86Config y <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/files/dmesg-openbsd34-damog.txt?PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">aquí</a> mi dmesg.

También he tenido problemas con el ventilador. En Linux utilizaba el paquete `toshutils&#8217;, pero por acá <a href="http://web.archive.org/web/20031226230140/http://www.damog.net/index.php?gadget=blog&amp;action=single_view&amp;id=70&amp;PHPSESSID=b35e73a509d50b80c0c8eb29a7c802d2">no he podido</a>. Tendré que buscar un poco más de información.

<strong>Recomendación:</strong> Si quieren hacer una instalación de OpenBSD, compren CD&#8217;s originales. Ayudará al proyecto, los ayudará a ustedes, pues a la larga es mejor tener los paquetes precompilados disponibles, el árbol de ports y demás, en sus CD&#8217;s, además de que el arte y el diseño es muy bello.

En fin, me agradó mucho el sistema, hasta ahora. Sigo conociéndolo y asombrándome de la simplicidad, de la limpieza, de la flexibilidad y demás. Y muchísimas <strong>gracias</strong> a todos aquellos que me ayudaron: Al <a href="http://web.archive.org/web/20031226230140/http://www.mig-29.net/">MiG</a>, por recomendarme tanto los sistemas operativos *BSD; a <a href="http://web.archive.org/web/20031226230140/http://bsdcoders.org/%7Ealex">Alex</a>, por conminarme a seguir aprendiendo sobre OpenBSD, aún cuando no le parezcan interesantes mis preguntas :P; a <a href="http://web.archive.org/web/20031226230140/http://www.tungsteno.com/">Wulfrano</a>, por hacer la imagen de OpenBSD 3.4 y por inspirarme a instalarlo gracias a su conferencia del ESIME, y en general a toda la banda.

:-D</li>
