title: "Phusion Passenger™ on Debian"
date: 2009/8/7 17:32:02
tags:
- apache
- beer
- debconf
- debian
- nginx
- passenger
- rails
---
During [DebConf 9](http://debconf9.debconf.org) I had the opportunity to work together with [Señor Micah](http://www.flickr.com/photos/sfllaw/1263528602/) to try to bring [Passenger](http://www.modrails.com/) back to shape and get it back to the [NEW queue on Debian](http://ftp-master.debian.org/new.html). We spent way too much time dealing with the build for the [pkg-ruby-extras build model](https://wiki.debian.org/Teams/Ruby) than to the actual fixing and updating. At the end we came up with a very well updated and **DFSG-compatible** (in contrast to the one that [Brightbox](http://www.brightbox.co.uk/) provides, which isn't bad either to be honest) package for the 2.2.4 version.

Our current main interest was trying to get the package into Debian by cleaning up the [licensing issues](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=488753) on some of the included files and try to come up with improvements in the near future (such as using Passenger directly from [nginx](http://nginx.net/), instead of the [Apache](http://httpd.apache.org)-only module). The future is bright and it'll bring sunshine to all of us.

Given that the package is still on the queue and there's a hell lot of other packages to be processed, you can grab the package *here* and if it fulfills your expectations, make sure you offer me and/or Micah a beer next time you see us around.
