title: "Feedbag significantly faster than Rfeedfinder"
date: 2009/3/7 16:57:45
tags:
- benchmark
- feedbag
- feeds
- ruby
---
Alright so [Feedbag](http://github.com/damog/feedbag) looks to be significantly faster than [Rfeedfinder](http://rfeedfinder.rubyforge.org/) when tested against different URIs:

          user     system      total        real
    damog.net:
     feedbag
      0.280000   0.050000   0.330000 (  1.486712)
      rfeedfinder
      0.140000   0.030000   0.170000 (  4.259612)
    http://cnn.com:
     feedbag
      0.200000   0.020000   0.220000 (  0.703625)
      rfeedfinder
      0.240000   0.030000   0.270000 (  1.071508)
    scripting.com:
     feedbag
      0.170000   0.030000   0.200000 (  0.682292)
      rfeedfinder
      0.220000   0.040000   0.260000 (  1.668234)
    mx.planetalinux.org:
     feedbag
      0.550000   0.050000   0.600000 (  1.636884)
      rfeedfinder
      0.760000   0.120000   0.880000 (  3.189143)
    http://feedproxy.google.com/UniversoPlanetaLinux:
     feedbag
      0.030000   0.010000   0.040000 (  0.696871)
      rfeedfinder
      0.160000   0.030000   0.190000 (  1.613874)

As [I had previously blogged](/blog/2009/02/11/feedbag-now-using-feedvalidator/), Feedbag also can use [feedvalidator](http://feedvalidator.rubyforge.org/) to get most accurate results. The results above were tested with `feedvalidator` deactivated, which is the default behavior anyway. When activating it, the following results are seen:

          user     system      total        real
    damog.net:
     feedbag
      0.390000   0.070000   0.460000 (  3.434350)
      rfeedfinder
      0.170000   0.030000   0.200000 (  2.819837)
    http://cnn.com:
     feedbag
    Feed looked like feed but might not have passed validation or timed out
      0.200000   0.020000   0.220000 (  1.103810)
      rfeedfinder
      0.200000   0.030000   0.230000 (  1.036161)
    scripting.com:
     feedbag
      0.220000   0.030000   0.250000 (  1.282081)
      rfeedfinder
      0.150000   0.040000   0.190000 (  1.520435)
    mx.planetalinux.org:
     feedbag
      0.660000   0.050000   0.710000 (  2.784598)
      rfeedfinder
      0.760000   0.110000   0.870000 (  3.984222)
    http://feedproxy.google.com/UniversoPlanetaLinux:
     feedbag
      0.050000   0.010000   0.060000 (  1.275603)
      rfeedfinder
      0.170000   0.030000   0.200000 (  2.067279)

So Rfeedfinder appears to be slightly faster on small pages but even slower than Feedbag with big ones (even when Feedbag calls `feedvalidator` which makes it to make the request twice!). Also, it's noticeable that Feedbag will return more significant results than Rfeedfinder:

    >> Feedbag.find "http://damog.net"
    => ["http://feeds.feedburner.com/InfinitePigTheorem", "http://damog.net/category/feed/", "http://damog.net/tag/feed/", "http://github.com/damog/rfeed", "http://damog.net/tag/rfeed/", "http://damog.net/comments/feed/"]
    >> require "rfeedfinder"
    => true
    >> Rfeedfinder.feed "http://damog.net"
    => "http://feedproxy.feedburner.com/InfinitePigTheorem"

After this, it really makes more sense to use Feedbag than Rfeedfinder.

The benchmark code can be found <a href="http://github.com/damog/feedbag/blob/bb091ae9ff6c54883763fb62f99ed746a66fb259/benchmark/rfeedfinder_benchmark.rb">here</a>. As I wrote the bechmark test, I did put the Feedbag requests first in order to make it less likely to have better results for Feedbag for a possible cache favoring it, even then, Feedbag was superior.
