---
title: "Introducing Apache2::EmbedFLV – Exposing FLVs with Flowplayer and a customized interface"
date: 2009-01-17 18:22:43
tag:
- apache
- flowplayer
- flv
- mod_perl
- perl
- swf
---
**Situation**

You have a bunch of Flash videos, FLV files. Every once in a while you dump new files on your publicly accessible Apache directory. You would like to give your users the ability to play those FLVs within a webpage you provide, instead of just serving them the files for a direct download. Maybe you want this for all FLVs, not only an specific directory.

**Solution**

[Apache2::EmbedFLV](https://metacpan.org/pod/Apache2::EmbedFLV)!

    <Files ~ "\.flv$">
      SetHandler modperl
      PerlResponseHandler Apache2::EmbedFLV
    </Files>

So now, all your FLV files will be served through `Apache2::EmbedFLV` on mod_perl with a neat interface you can define yourself, and using the very nice and GPL'ed <a href="http://flowplayer.org">Flowplayer</a>.

Apache2::EmbedFLV uses a default template, but you can define your own with:

    <Files ~ "\.flv$">
      SetHandler modperl
      PerlSetVar template /path/to/your/template.tt
      PerlResponseHandler Apache2::EmbedFLV
    </Files>

Also, Apache2::EmbedFLV expects to find Flowplayer (`flowplayer.swf` and `flowplayer.controls.swf`) on `http://your.server.com/flowplayer.swf`, the root of your server. So you can do something like this to make it work:

    Alias /flowplayer.swf /home/web/flowplayer/flowplayer.swf
    Alias /flowplayer.controls.swf /home/web/flowplayer/flowplayer.controls.swf

Or, you just define the flowplayer variable:

    <Files ~ "\.flv$">
      SetHandler modperl
      # relative to the document root
      PerlSetVar flowplayer /swf/flowplayer.swf
      # or absolute:
      PerlSetVar flowplayer http://my.other.server/was/hacked/flowplayer.swf
      PerlResponseHandler Apache2::EmbedFLV
    </Files>

**Action!**

You can see it in action at <a href="http://axiombox.com/apache2-embedflv/flv">http://axiombox.com/apache2-embedflv/flv</a>.

<a href="http://axiombox.com/apache2-embedflv/flv/radiohead_bodysnatchers2.flv">This Radiohead video</a> is particularly cool :-)

**Getting it**

- More information at its homepage, <a href="http://axiombox.com/apache2-embedflv">http://axiombox.com/apache2-embedflv</a>.
- <a href="http://search.cpan.org/~damog/Apache2-EmbedFLV-0.2/">CPAN module</a>.
- <a href="http://github.com/damog/apache2-embedflv">Git repository</a>, as usual, on GitHub.

UPDATE: Oops! Fixed link to Flowplayer's website! <a href="http://flowplayer.org">flowplayer.org</a>. Thanks to those who noticed and let me knew.
