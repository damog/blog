title: "The new Planeta Linux engine"
date: 2009/11/11 19:06:50
tags:
- git
- perl
- planet
- planeta linux
- planetplanet
- venus
---
So I've spent quite some time in the last couple of months (whenever I had a chance, actually), to redesign how the core of [Planeta Linux](http://planetalinux.org) works, and I'll explain all the changes I've made to make it a much better solution that fully fits our current needs. If you are reading this with a feed reader, **star this item, share the item, retweet the post**! Let everyone know we are doing this for the Linux Latin American community!

![http://planetalinux.org/](/files/misc/planetalinux-125x125.jpg)

If you're naive enough, you'll think about Planeta Linux as a simple [Planet](http://planetplanet.org) aggregation instance with a different set of people collections, which we used to call, ironically, instances, which aren't anything else but countries. If you don't know how we've been doing Planeta Linux for almost **[five years now](/blog/2004/10/12/planetalinux/)**, you'll think it's all just `config.ini` being fed to the `planetplanet` binary. Well, it has been like that, yes, but having a big set of planets (more than ten now) makes it a bit of a hassle to do any changes or try to do anything else but add, edit and remove people. The way we were handling it with Apache was already documented in the [past](/blog/2008/11/15/configuracion-dinamica-en-apache/).

Some of the multiple issues Planeta Linux has had in the past could be summarized as:

- Inability to have a unified templates set.
- Repeated feeds of the same person on multiple countries.
- Inability to know when a feed started to properly return valid items.
- Error-prone parsing.
- Difficulty to test on local environments.
- Decentralized subdomains with difficulty on sharing content or awkward navigation between contries.

And the list could go on. I realized this was a huge pain in the ass when I had the intention to centralize the subdomains into a single one: Instead of using the model `$country.planetalinux.org`, everything would have to come out from just `planetalinux.org`. Changing to that on our previous scheme was simply an *hemorrhoid*. So, I changed it all and the new model is much better and robust, even though you probably don't see a single difference on the current Planeta Linux output.

![](/old/stereonaut/2009/11/authors-file.jpg)

I started by getting rid of the horrible `config.ini` editing. Whenever you want to add an author, you simple drop a YAML file into the authors directory. It doesn't matter the location of the file as long as it's inside the `authors` directory. When I started importing all of the subscribers, I ended up with more than **620+ author files** so I made a simple separation of files a-la CPAN: `authors/d/da/david_moreno.yml`. But at the end, it doesn't really matter, a) what your file is named, and b) where you put it, they will all get parsed and interpreted. Now, inside that YAML file there's a bunch of goodies. Firstly, you have the feed URL, the name of the person, his or her email, an array of countries where the feed should be aggregated into and other stuff such as the path for the hackergotchi, a `twitter` parameter for the [Twitter](http://twitter.com/) feed, an `enabled` switch, etc. The good thing about it is that you can have all the parameters you want so we can build on top of that later (maybe identica profiles, LastFM usernames, whatever).

One of my future intentions is to have also an array of feeds on each author file which would empower us to have the same info for several feeds. With the new model, this should be much easier to implement anyway.

Anyway, basically, when you want to add or edit a feed, you just edit or drop the file on the authors directory. **KISS**.

Second big change, we switched to [Planet Venus](http://intertwingly.net/code/venus/), as opposed to just Planet for the aggregation engine and you no longer need to have it installed since it's included now on the entire Planeta Linux tree under the `venus` directory. Venus implements a whole new world of features and good stuff on top of Planet, it was just a no-brainer to switch to it.

However, Venus still requires `config.ini` for each of its instances, so this is where the whole build process comes to play. I implemented a tool, `script/build` that does exactly that, it gathers all the info from authors and builds each of the countries. To create a new country, you just basically only have to add it to `config/countries.list`. The build script will use all of them as tasks and execute them at will.

Now, how the build tool works? As said, it gathers the data from authors and generates a `config.ini` on the fly. There's a `config.ini` template file on the template directory, as well as an `index.html` template (and `rss.xml`), and for the build script, it's just another [TT](http://template-toolkit.org/) file so you can do all sorts of awesome and crazy shit with it. So it's all generated dynamically, with the information from authors, information from the `config` directory and it dumps it all on the `www` directory. Because of that, you can generate your own working copy of Planeta Linux or implement others or just play with it!

So basically, the whole process is like this for each of the countries:

![](/old/stereonaut/2009/11/build-process.jpg)

The good thing about it is that there's no interaction for the administrator to deal with the config.ini either when adding an instance since I integrated a tool that adds a new subscriber to the authors tree automatically:


    ~/axiombox/planetalinux :master $ ./script/planetalinux.pl help add
    planetalinux.pl add [-p] [long options...]

    Adds a new author to Planeta Linux. The name, email, feed URL and
    country where to place the author are mandatory. If the hackergotchi
    image path is provided, the script will check the size for the image
    and resize it if needed (ImageMagick needed). Any other flags and
    values passed to this command will be appended on the resulting
    YAML file.

    Examples:

    ./script/planetalinux.pl add \
    --feed http://example.com/feed \
    --name &amp;amp;quot;Tía Chonita&amp;amp;quot; \
    --email tia@chonita.com \
    --countries ve \
    --hackergotchi ~/images/chonita.jpg \
    --twitter @chonita

    ./script/planetalinux.pl add \
    --feed http://blog.wordpress.com/feed/atom \
    --name &amp;amp;quot;Isela Crelló&amp;amp;quot; \
    --email yeah@yeah.com.mx \
    --countries mx,sv,gt \

    ./script/planetalinux.pl add \
    --feed http://cofradia.sucks/feed \
    --portal \
    ...etc

    --feed feed URL -- mandatory
    --name name of author of feed -- mandatory
    --email email of author of feed -- mandatory
    --countries country(ies) of author -- mandatory
    --hackergotchi path to the hackergotchi image -- optional
    -p --portal portal site flag -- optional
    --twitter twitter feed of author -- optional

    ~/axiombox/planetalinux :master $

Cool things about this new "adder" script:

- It ensures that the author has an stored feed, name, email and country, at the very least.
- It checks whether the URL is a valid feed URL against the [W3C feed validator](http://validator.w3.org/feed/).
- It checks that the email is valid.
- It checks that the countries specified are supported by the system.
- **It takes a file path for the hackergotchi and using [ImageMagick](http://www.imagemagick.org/script/index.php), it resizes it, converts it into the proper image type and places it under the appropiate image heads path.**
- It creates the YAML and places under an appropriate location under the authors directory.
- It's awesome :)

### Tutorial

Now, one of the good things about all of this is that you can create your own Planeta Linux running right there on your machine, given that well, it's just a nice big glue involving Perl for the processing, Python for the parsing and aggregation, the cache is stored on the tree as well, etc.

To start, you'll have to clone the repository if you haven't done it yet:

    $ git clone git://github.com/planetalinux/planetalinux.git

Change the directory to the repository and just run the dependencies installer for all of the modules used:

    $ sudo perl installdeps.pl

Note that you'll have to be running [perl 5.10](http://dev.perl.org/perl5/news/2007/perl-5.10.0.html) (it's been stable for almost two years now, dude! **Upgrade**!). If you already have most of the modules installed on your system, this shouldn't take that long. If you have nearly no Perl modules installed, it will probably take a little while. It might even need your intervention for some basic CPAN configuration. Once it's done, you should see something like this, at the end of the output:

    .. testing loading modules...
    - App::Cmd
    - App::PPBuild
    - Config::IniFiles
    - Data::Validate::Email
    - DateTime
    - File::MimeInfo::Simple
    - File::Path
    - Modern::Perl
    - Net::Domain::ES::ccTLD
    - Template
    - WebService::Validator::Feed::W3C
    - YAML::Syck

    .. done. enjoy!

    .. please make sure you have PerlMagick installed.
    .. the recommended way is: `port install p5-perlmagick` in Mac,
    .. ..or 'aptitude install perlmagick' in Debian/Ubuntu.

Now, for the [ImageMagick Perl bindings](http://www.imagemagick.org/script/perl-magick.php) (for the "adder" funcionality) you'll need to install it depending on your operating system. If you are running some flavor of Debian (or Ubuntu), you just have to install the perlmagick package. On MacOS, I recommend installing the ImageMagick MacPorts port with the `+perl` flag. Depending on your configuration, you might need to install the `Image::Magick` module either from the CPAN shell or downloading it from web. Once all of that is done, you can just fire up the building system:

    $ ./script/build all

You can just fire up a single country or other tasks by seeing which ones are available:

    $ ./script/build --tasks

At this point you can go to your browser and navigate to the `www` directory on the repository where all the output has been dumped.

If you have any issues running your own local copy of Planeta Linux, please put a comment on this post, I'll glad you help you solve it and you'll be helping us making Planeta Linux much better than ever.
