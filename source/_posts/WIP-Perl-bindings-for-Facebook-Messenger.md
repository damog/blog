title: "WIP: Perl bindings for Facebook Messenger"
date: 2016-08-21 18:35:26
tags:
- facebook
- messenger
- perl
---
A couple of weeks ago I started looking into wrapping the [Facebook Messenger API](https://developers.facebook.com/docs/messenger-platform) into Perl. Since all the calls are extremely simple using a REST API, I thought it could be easier and simpler even, to provide a small framework to hook bots using [PSGI/Plack](http://plackperl.org/).

So I started putting some things together and with a very simple interface you could do a lot:

    use strict;
    use warnings;
    use Facebook::Messenger::Bot;

    my $bot = Facebook::Messenger::Bot->new({
        access_token   => '...',
        app_secret     => '...',
        verify_token   => '...'
    });

    $bot->register_hook_for('message', sub {
        my $bot = shift;
        my $message = shift;

        my $res = $bot->deliver({
            recipient => $message->sender,
            message => { text => "You said: " . $message->text() }
        });
        ...
    });

    $bot->spin();

You can hook a script like that as a `.psgi` file and plug it in to whatever you want.

Once you have some more decent user flow and whatnot, you can build something like:

<p align="center">
    <img src="https://github.com/damog/facebook-messenger-perl/blob/master/media/sample-01.gif?raw=true">
</p>

...using a *simple* script like [this one](https://github.com/damog/facebook-messenger-perl/blob/master/examples/reply-bot.pl).

The work is not finished and not yet CPAN-ready but I'm posting this in case someone wants to join me in this mini-project or have suggestions, the work in progress is [here](https://github.com/damog/facebook-messenger-perl).

Thanks!
