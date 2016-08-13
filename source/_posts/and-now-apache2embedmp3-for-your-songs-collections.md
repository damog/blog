title: "And now Apache2::EmbedMP3 for your songs collections!"
date: 2009/2/2 15:01:52
tags:
- apache
- mod_perl
- mp3
---
After I spent time working on <a href="/blog/2009/01/17/introducing-apache2embedflv-exposing-flvs-with-flowplayer-and-a-customized-interface/">Apache2::EmbedFLV</a>, I thought it was a good idea to do the same for audio files, specifically MP3 files.

So now that you have your MP3 files on your web server and they are accessible to the world, you may want to show them with an embedded audio player. Well, Apache2::EmbedMP3 is exactly for you!

EmbedMP3 uses the fabulous <a href="http://wpaudioplayer.com/">WP Audio Player</a>, a small, elegant, GPL Flash audio player, similarly to how <a href="http://search.cpan.org/~damog/Apache2-EmbedFLV-0.2/">Apache2::EmbedFLV</a> uses Flowplayer. The interesting thing about EmbedMP3 is that you can display more interesting data on the template such as song name, artist, album, year and also lyrics, which was an interesting feature I added. In this fashion, it's very easy to just drop a whole bunch of files into a directory and all be served with the custom interface.

You have to instruct Apache2:
<pre><code>&lt;Files ~ "\.mp3$"&gt;
       SetHandler modperl
       PerlSetVar wpaudioplayer /audio-player/player.swf
       PerlSetVar wpaudioplayer_js /audio-player/wpaudioplayer.js
       PerlResponseHandler Apache2::EmbedMP3
&lt;/Files&gt;
</code></pre>
And that's it. Take a look at the documentation to see how to point it to specific locations for WP Audio Player, template file, etc.

You can see the hack in action at <a href="http://dev.axiombox.com/~david/mp3">http://dev.axiombox.com/~david/mp3</a>. If it struggles a bit by buffering, it's because that's directly from my home Internet connection, so give it a small break :-) And, as I suggested <a href="http://axiombox.com/apache2-embedflv/flv/radiohead_bodysnatchers2.flv">the Radiohead video</a> with EmbedFLV, I suggest now <a href="http://dev.axiombox.com/~david/mp3/Black_Eyed_Peas_-_Like_That.mp3">this Black Eyed Peas song</a>, Like That, it's very catchy and I love it ;-)

Go get the code at the <a href="http://github.com/damog/apache2-embedmp3">Git repo</a> or at <a href="http://search.cpan.org/~damog/Apache2-EmbedMP3-0.1/">CPAN</a> (once it's updated and published).
