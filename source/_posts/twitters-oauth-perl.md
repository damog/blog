Title: Twitter's OAuth + Perl
Date: 2009-05-21 14:06:42
Tags: oauth,perl,twitter
---
During the last week, unbeatable <a href="http://bulknews.vox.com/">Tatsuhiko Miyagawa</a> uploaded <a href="http://search.cpan.org/dist/Net-Twitter-OAuth/">Net::Twitter::OAuth</a> to <a href="http://search.cpan.org/">CPAN</a>, which provides an awesome interface for <a href="http://search.cpan.org/dist/Net-OAuth-Simple/">Net::OAuth::Simple</a> and <a href="http://twitter.com/">Twitter</a> by subclassing <a href="http://search.cpan.org/dist/Net-Twitter/">Net::Twitter</a>. This way, it's very easy to develop Twitter client applications using its <em>new</em> <a href="http://apiwiki.twitter.com/OAuth-FAQ">OAuth method</a> dropping the need for users to hand their credentials to third parties.

You will have to register your application on Twitter previously. You can do so <a href="http://twitter.com/oauth_clients">here</a>. If this is a web application that you will be building, you can provide a callback URL which is the page where the user will get redirected once she has granted access to your application. If you just want to test, setting a desktop application is probably the way to go.

Once you have registered your application, you will get two strings, key and secret consumer. Refer to general <a href="http://oauth.net/">OAuth</a> documentation for deeper details.

Install Net::Twitter::OAuth as any other Perl module:

[shell]
$ sudo cpan Net::Twitter::OAuth
[/shell]

Now, using it is very simple:

<code lang="perl">
my $client = Net::Twitter::OAuth->new(
  consumer_key    => "YOUR-CONSUMER-KEY",
  consumer_secret => "YOUR-CONSUMER-SECRET",
);
</code>

No transactions or requests have been made yet. Here you need the user's access and secret tokens. If you already have them, which means that the user has already gone through the authorization process, you have to pass it now (you already stored them on database, a configuration file or whatever the data model you use):

<code lang="perl">
if ($access_token && $access_token_secret) {
  $client->oauth->access_token($access_token);
  $client->oauth->access_token_secret($access_token_secret);
}
</code>

Now you can query Twitter so it can provide you access:

<code lang="perl">
unless ($client->oauth->authorized) {
  # The client is not yet authorized: Do it now
  print "Authorize this app at ", $client->oauth->get_authorization_url, " and hit RET\n";

  <STDIN>; # wait for input

  my($access_token, $access_token_secret) = $client->oauth->request_access_token;
  save_tokens($access_token, $access_token_secret); # if necessary
}
</code>

All these snippets come from the example's of Net::Twitter::OAuth. So basically, if you are not authorized, which means that either the user hasn't even been prompted for authorization or denied access before, then you get the authorization URL which you can give to the user to visit.

Once the user has granted access, you can call <tt>request_access_token</tt> which will return the user's tokens. Here's where you can save those tokens for future use.

After that block, you are pretty much done and can use the regular Net::Twitter methods:

<code lang="perl">
my $res = $client->update({ status => 'me ownz oauth!!1' });
</code>

Soon, a real life application post using <a href="http://search.cpan.org/dist/HTTP-Engine/">HTTP::Engine</a>, <a href="http://search.cpan.org/dist/KiokuDB/">KiokuDB</a> and Net::Twitter::OAuth.