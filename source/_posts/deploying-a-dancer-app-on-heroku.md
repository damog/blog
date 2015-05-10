title: "Deploying a Dancer app on Heroku"
Date: 2012-07-16 21:03:45
Tags: dancer,heroku,perl
---
There's a <a href="http://blog.kraih.com/mojolicious-in-the-cloud-hello-heroku">few</a> different posts out there on how to run Perl apps, such as Mojolicious-based, on Heroku, but I'd like to show how to deploy a <a href="http://perldancer.org/">Perl Dancer</a> application on <a href="http://www.heroku.com/">Heroku</a>.

The startup script of a Dancer application (bin/app.pl) can be used as a <a href="http://plackperl.org/">PSGI</a> file. With that in mind, I was able to take the good work of <a href="http://bulknews.typepad.com/">Miyagawa's</a> <a href="https://github.com/miyagawa/heroku-buildpack-perl">Heroku buildpack</a> for general PSGI apps and hack it a little bit to use Dancer's, specifically. What I like about Miyagawa's approach is that uses the fantastic <a href="http://search.cpan.org/~miyagawa/App-cpanminus-1.5015/bin/cpanm">cpanm</a> and makes it available within your application, instead of the monotonous cpan, to solve dependencies.

Let's make a simple Dancer app to show how to make this happen:

<code lang="bash">
/tmp $ dancer -a heroku
+ heroku
+ heroku/bin
+ heroku/bin/app.pl
+ heroku/config.yml
+ heroku/environments
+ heroku/environments/development.yml
+ heroku/environments/production.yml
+ heroku/views
+ heroku/views/index.tt
+ heroku/views/layouts
+ heroku/views/layouts/main.tt
+ heroku/MANIFEST.SKIP
+ heroku/lib
heroku/lib/
+ heroku/lib/heroku.pm
+ heroku/public
+ heroku/public/css
+ heroku/public/css/style.css
+ heroku/public/css/error.css
+ heroku/public/images
+ heroku/public/500.html
+ heroku/public/404.html
+ heroku/public/dispatch.fcgi
+ heroku/public/dispatch.cgi
+ heroku/public/javascripts
+ heroku/public/javascripts/jquery.js
+ heroku/t
+ heroku/t/002_index_route.t
+ heroku/t/001_base.t
+ heroku/Makefile.PL
</code>

Now, you already know that by firing 'perl bin/app.pl' you can get your development server up and running. So I'll just proceed to show how to make this work on Heroku, you should already have your development environment configured for it:

<code lang="bash">
/tmp $ cd heroku/
/tmp/heroku $ git init
Initialized empty Git repository in /private/tmp/heroku/.git/
/tmp/heroku :master $ git add .
/tmp/heroku :master $ git commit -a -m 'Dancer on Heroku'
[master (root-commit) 6c0c55a] Dancer on Heroku
22 files changed, 809 insertions(+), 0 deletions(-)
create mode 100644 MANIFEST
create mode 100644 MANIFEST.SKIP
create mode 100644 Makefile.PL
create mode 100755 bin/app.pl
create mode 100644 config.yml
create mode 100644 environments/development.yml
create mode 100644 environments/production.yml
create mode 100644 lib/heroku.pm
create mode 100644 public/404.html
create mode 100644 public/500.html
create mode 100644 public/css/error.css
create mode 100644 public/css/style.css
create mode 100755 public/dispatch.cgi
create mode 100755 public/dispatch.fcgi
create mode 100644 public/favicon.ico
create mode 100644 public/images/perldancer-bg.jpg
create mode 100644 public/images/perldancer.jpg
create mode 100644 public/javascripts/jquery.js
create mode 100644 t/001_base.t
create mode 100644 t/002_index_route.t
create mode 100644 views/index.tt
create mode 100644 views/layouts/main.tt
/tmp/heroku :master $
</code>

And now, run <tt>heroku create</tt>, please note the buildpack URL, <tt>http://github.com/damog/heroku-buildpack-perl.git</tt>:

<code lang="bash">
/tmp/heroku :master $ heroku create --stack cedar --buildpack http://github.com/damog/heroku-buildpack-perl.git
Creating blazing-beach-7280... done, stack is cedar
http://blazing-beach-7280.herokuapp.com/ | git@heroku.com:blazing-beach-7280.git
Git remote heroku added
/tmp/heroku :master $
</code>

And just push:

<code lang="bash">
/tmp/heroku :master $ git push heroku master
Counting objects: 34, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (30/30), done.
Writing objects: 100% (34/34), 40.60 KiB, done.
Total 34 (delta 3), reused 0 (delta 0)

-----> Heroku receiving push
-----> Fetching custom buildpack... done
-----> Perl/PSGI Dancer! app detected
-----> Bootstrapping cpanm
Successfully installed JSON-PP-2.27200
Successfully installed CPAN-Meta-YAML-0.008
Successfully installed Parse-CPAN-Meta-1.4404 (upgraded from 1.39)
Successfully installed version-0.99 (upgraded from 0.77)
Successfully installed Module-Metadata-1.000009
Successfully installed CPAN-Meta-Requirements-2.122
Successfully installed CPAN-Meta-2.120921
Successfully installed Perl-OSType-1.002
Successfully installed ExtUtils-CBuilder-0.280205 (upgraded from 0.2602)
Successfully installed ExtUtils-ParseXS-3.15 (upgraded from 2.2002)
Successfully installed Module-Build-0.4001 (upgraded from 0.340201)
Successfully installed App-cpanminus-1.5015
12 distributions installed
-----> Installing dependencies
Successfully installed ExtUtils-MakeMaker-6.62 (upgraded from 6.55_02)
Successfully installed YAML-0.84
Successfully installed Test-Simple-0.98 (upgraded from 0.92)
Successfully installed Try-Tiny-0.11
Successfully installed HTTP-Server-Simple-0.44
Successfully installed HTTP-Server-Simple-PSGI-0.14
Successfully installed URI-1.60
Successfully installed Test-Tester-0.108
Successfully installed Test-NoWarnings-1.04
Successfully installed Test-Deep-0.110
Successfully installed LWP-MediaTypes-6.02
Successfully installed Encode-Locale-1.03
Successfully installed HTTP-Date-6.02
Successfully installed HTML-Tagset-3.20
Successfully installed HTML-Parser-3.69
Successfully installed Compress-Raw-Bzip2-2.052 (upgraded from 2.020)
Successfully installed Compress-Raw-Zlib-2.054 (upgraded from 2.020)
Successfully installed IO-Compress-2.052 (upgraded from 2.020)
Successfully installed HTTP-Message-6.03
Successfully installed HTTP-Body-1.15
Successfully installed MIME-Types-1.35
Successfully installed HTTP-Negotiate-6.01
Successfully installed File-Listing-6.04
Successfully installed HTTP-Daemon-6.01
Successfully installed Net-HTTP-6.03
Successfully installed HTTP-Cookies-6.01
Successfully installed WWW-RobotRules-6.02
Successfully installed libwww-perl-6.04
Successfully installed Dancer-1.3097
29 distributions installed
-----> Installing Starman
Successfully installed Test-Requires-0.06
Successfully installed Hash-MultiValue-0.12
Successfully installed Devel-StackTrace-1.27
Successfully installed Test-SharedFork-0.20
Successfully installed Test-TCP-1.16
Successfully installed Class-Inspector-1.27
Successfully installed File-ShareDir-1.03
Successfully installed Filesys-Notify-Simple-0.08
Successfully installed Devel-StackTrace-AsHTML-0.11
Successfully installed Plack-0.9989
Successfully installed Net-Server-2.006
Successfully installed HTTP-Parser-XS-0.14
Successfully installed Data-Dump-1.21
Successfully installed Starman-0.3001
14 distributions installed
-----> Discovering process types
Procfile declares types -&amp;gt; (none)
Default types for Perl/PSGI Dancer! -&amp;gt; web
-----> Compiled slug size is 2.7MB
-----> Launching... done, v4
http://blazing-beach-7280.herokuapp.com deployed to Heroku

To git@heroku.com:blazing-beach-7280.git
* [new branch] master -&amp;gt; master
/tmp/heroku :master $
</code>

And you can confirm it works:
<p style="text-align: center;"><a href="http://damog.net/old/stereonaut/2012/07/Screen-Shot-2012-07-16-at-8.54.03-PM.png"><img class="aligncenter  wp-image-1313" title="Screen Shot 2012-07-16 at 8.54.03 PM" src="http://damog.net/old/stereonaut/2012/07/Screen-Shot-2012-07-16-at-8.54.03-PM.png" alt="" width="538" height="346" /></a></p>
Please note that the environment it runs on is "deployment". The backend server it uses is the great Starman, also by the great Miyagawa.

Now, if you add or change dependencies on Makefile.PL, next time you push, those will get updated.

Very cool, right? :)
