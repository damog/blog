title: "Good looking Irb"
Date: 2008-12-29 10:01:51
Tags: config,irb,ruby,tips
---
<a href="http://en.wikipedia.org/wiki/Interactive_Ruby_Shell">Irb</a> is a pain to work with... when you don't know it enough. Fortunately, it can be configured extensively enough to make your Ruby interactive sessions much smoother. Pocahontas asked me to post my Irb configuration:
<pre># ~/.irbrc
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 5000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

# load rubygems and wirble
require 'rubygems' rescue nil
require 'wirble'
require 'utility_belt'

# load wirble
Wirble.init
Wirble.colorize</pre>
Which makes Irb to look much much better:

<img class="aligncenter size-full wp-image-763" title="irb" src="http://damog.net/old/axiombox/2008/12/irb.png" alt="irb" width="590" height="224" />

But it is not only coloring the features you are getting, but also Readline support, command history saving, tab completion, libraries loaded by default, persistent history with Wirble, etc, etc. as you can see yourself on the very self-explanatory configuration file. Enjoy.

Update: I have to thank my co-worker Galin for pointing me most of these neat features.