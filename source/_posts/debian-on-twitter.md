title: "Debian on Twitter"
date: 2009/3/22 09:33:21
tags:
- debian
- gpg
- twitter
---
Or... for those who care about <a href="http://twitter.com">Twitter</a> and <a href="http://debian.org">Debian</a> :)

We've setup a Twitter account for the project to use on Twitter. Go follow it, go now!
<p style="text-align: center;"><a href="http://twitter.com/debianproject"><strong>twitter.com/debianproject</strong></a></p>

Now, the interesting part about this is that any Debian developer with a GPG key on the Debian keyring can tweet to it. You basically only have to do something like this:

    $ echo "Squeeze is scheduled for Winter 2014" | gpg --clearsign | lwp-request -m POST http://twitter.debian.net/post

...or, what it's the same, just send a clearsigned POST data to `http://twitter.debian.net/post`. If the data is signed by a Debian developer, it'll go through and post it. The Debian uid is appended on the tweet, as found on Debian's LDAP DB, so if `joetheplumber@d.o` is the one posting, it'll be posted with "(via joetheplumber)" on it.

If you are more interested about this, you can go to http://twitter.debian.net/ (dead link now) where you will find deeper information and details about this service.

I encourage you, Debian user and advocate, to start following the *@debianproject* account; and I encourage you, Debian developer, to communicate with our users and advocates by using and posting to this service.

More news to follow soon.

**UPDATE**: Support for [Identi.ca](http://identi.ca) has been added and now both <a href="http://twitter.com/debianproject">Twitter</a> and <a href="http://identi.ca/debianproject">Identi.ca</a> accounts are updated at once and sync'ed.
