title: "Cheating the world you tweet less"
date: 2009/6/8 16:41:56
tags:
- perl
- rubx
- twitter
---
The number of updates on my <a href="http://twitter.com/amsterdamog">Twitter page</a> kind of <strong>bothers me</strong> sometimes. It's a reminder of the amount of time I've spent and wasted on Twitter, it's an ever-itching mole in front of my face. However, I can cheat the system and society and still feel good about myself. What if I just remove all freaking replies I've made, <em>except</em> for those of people I do care about (like <a href="http://maggit.net">my fiance</a> or <a href="http://twitter.com/rubx">Ruby Boobie</a>)? And also, I don't want to remove very recent replies.

Well, let's just do it already.
<code lang="perl">
#!/opt/local/bin/perl

use Modern::Perl;

use Net::Twitter;
use DateTime::Format::DateParse;
use DateTime;

binmode STDOUT, ":utf8";

my $t = Net::Twitter->new(
    user => shift @ARGV || 'lazy_fuck', 
    password => shift @ARGV || 'bl0wm3');

my $whitelist = [qw/maggit rubx axiombox/];

my $then = DateTime->now;
$then->subtract(days => 5);

my $x = 1;
for my $i (1..80) {

    my $tweets = $t->user_timeline({ page => $i, count => 200 })
        or die "No fish for you, loser.\n";

    for my $h (@$tweets) {
        next unless $h->{"in_reply_to_screen_name"};
        next if grep { $_ eq $h->{"in_reply_to_screen_name"} } @$whitelist;

        my $date = DateTime::Format::DateParse->parse_datetime($h->{"created_at"});
        next unless $date < $then;

        say $x, ": (", $h->{"id"}, ") ", $h->{"text"};
        $t->destroy_status($h->{"id"});
        $x++;
    }
}
</code>

This little fucker will try to fetch your latest 16'000 tweets (if you have... <em>twat</em>, *grin*, more than that, you've got real issues and I cannot help there, get a shrink or something).

It'll make 80 requests for your timeline (remember Twitter gives you a 100-request hour limit), so only if the reply doesn't come from a certain people AND the reply is older than a given period of time (I'm setting it to one week for me), it'll get rid of it. If a friend doesn't see the reply in a week, she probably never will. After that, it just destroys the tweet (or it tries at least, from my experience, Twitter is still experimenting a hell lot of issues on their service).

That way you can cheat the system removing useless tweets that no one (not even you or the recipient) cares about anymore. Or just... don't give a shit, and you are all set too.

The first time I ran it, I went from like 6k tweets to 2500, which was a nice drop :-). If you feel like it, just grab it and customize to fit your needs. You will be needing the <a href="http://search.cpan.org">CPAN</a> modules <a href="http://search.cpan.org/dist/Modern-Perl">Modern::Perl</a>, <a href="http://search.cpan.org/dist/DateTime">DateTime</a>, <a href="http://search.cpan.org/dist/DateTime-Format-DateParse">DateTime::Format::DateParse</a> and of course, <a href="http://search.cpan.org/dist/Net-Twitter">Net::Twitter</a>.