---
title: "Webhook Setup with Facebook::Messenger::Bot"
date: 2016-08-29 20:42:40
tag:
- perl
- facebook
- messenger
---
The documentation for the [Facebook Messenger API](https://developers.facebook.com/docs/messenger-platform) points out how to setup your initial bot [webhook](https://developers.facebook.com/docs/messenger-platform/webhook-reference#setup). I just [committed](https://github.com/damog/facebook-messenger-perl/commit/925851fad5c09d644aee7b78d8eb644e5464e401) a quick patch that would make it very easy to setup a quick script to get it done using the *unreleased and still in progress* Perl's [Facebook::Messenger::Bot](https://github.com/damog/facebook-messenger-perl):

{{< highlight perl >}}
use Facebook::Messenger::Bot;

use constant VERIFY_TOKEN => 'imsosecret';

my $bot = Facebook::Messenger::Bot->new(); # no config specified!
$bot->expect_verify_token( VERIFY_TOKEN );
$bot->spin();
{{< /highlight >}}

This should get you sorted. What endpoint would that be, though? Well that depends on how you're giving Facebook access to your Plack's `.psgi` application.
