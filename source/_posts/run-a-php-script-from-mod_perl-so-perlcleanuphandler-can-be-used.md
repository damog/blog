title: "Run a PHP script from mod_perl so PerlCleanupHandler can be used"
date: 2009/2/19 19:21:44
tags:
- apache
- modperl
- php
---
<strong>Situation</strong>

You need to run a time consuming task after a PHP script is run. The task will have to reuse the <tt>POST/GET</tt> data that is being sent to the service. The task would have to be done once the client has gone away.

<strong>Solution</strong>

Use mod_perl's <tt>PerlFixupHandler</tt> to take the POST data, set the handler to be run by mod_php (or whatever else you are running it). Finally, use <tt>PerlCleanupHandler</tt> to run that task since that's exactly what that phase is for, once the client went away.

<strong>Explanation</strong>
<pre><code>&lt;Files ~ "myscript\.php$"&gt;
  SetHandler modperl
  PerlFixupHandler My::App::Fixup
&lt;/Files&gt;</code></pre>
Now, we are just indicating that we want a Fixup handler which is going to be run by <tt>My::App::Fixup</tt>. The Fixup phase runs right before content generation and delivery starts, which is the perfect moment to pass the execution of the PHP script.

So our handler would look like this:
<pre><code>package My::App::Fixup;

use strict;
use warnings;

use Apache2::Const -compile =&gt; qw/:common/;
use Apache2::Request;
use Apache2::RequestIO ();
use Apache2::RequestRec ();
use Apache2::RequestUtil ();
use Apache2::ServerUtil ();</code></pre>
Up to this moment, usual regular module-loading.
<pre><code>sub handler {
  my($r) = shift;</code></pre>
Now, we'll take the request object and assign it to $req.
<pre><code>  my $req = Apache2::Request-&gt;new($r);</code></pre>
We now register a subroutine, cleanup, to be hooked with the Cleanup phase. PerlCleanupHandler is great, it's the very last phase of a mod_perl execution, it will basically run after the client that made the request has gone away, once the connection with it has been terminated with the server. It's because of that nature, that it makes it the best place to make any kind of time consuming task, since we wouldn't want the client to wait for termination of that job. This phase is also not implemented in Apache, this is mod_perl specific.
<pre><code>  $r-&gt;push_handlers(PerlCleanupHandler =&gt; \&amp;cleanup);</code></pre>
Now, we set the handler for the next Apache phase to be handled as PHP:
<pre><code>  $r-&gt;handler("application/x-httpd-php");</code></pre>
In this point, I will have to start reading the POST information that was sent, since that will be gone when the Cleanup is reached:
<pre><code>  my $body = $req-&gt;body;

  my $st = {};

  for my $key ( keys %$body ) {
    $st-&gt;{$key} = $req-&gt;body($key);
  }</code></pre>
All the key-value pairs of the POST data are on the <tt>$st</tt> hash reference and I record it now on a "<tt>pnote</tt>", so I can catch it later:
<pre><code>  $r-&gt;pnotes("POST", $st);
  return Apache2::Const::OK;
}</code></pre>
So, this is the cleanup subroutine I registered previously. I prefered to do it this way, I could also have set an specific handler for PerlCleanupHandler on the Apache configuration, but I just wanted to do it this way.
<pre><code>sub cleanup {
  my($r) = shift;</code></pre>
I take now the request object again. The POST data is gone already, this is only for GET.
<pre><code>  my $req = Apache2::Request-&gt;new($r);
  my $table = $req-&gt;param;</code></pre>
I retrieve the information that I left before on the <tt>pnote</tt>.
<pre><code>  my $st = $r-&gt;pnotes("POST");

  for my $key ( keys %$table ) {
    $st-&gt;{$key} = $req-&gt;param($key);
  }</code></pre>
In this moment, <tt>$st</tt> has all POST and GET data on a hash reference. It's according to your application needs how to have proceeded with this.
<pre><code>  # All your time-consuming work
  # sleep 600;
  # or whatever you want :P
  # for the sake of this example, I'll just write the values to a file:
  open my $fh, "&gt;/tmp/myexample" or die $!;
  while(my($k, $v) = each %$st) {
    print $fh "$k -&gt;$v", "\n";
  }
  return Apache2::Const::OK;
}
1;</code></pre>
The good thing about this is that, you can run arbitrary time-consuming code from a Cleanup phase, and that it doesn't matter if you have to set the handler for the response phase to something else, like PHP, mod_perl will be able to handle it.

Now, myscript.php would look like this:
<pre><code>&lt;?php
print "&lt;pre&gt;";
print_r($_REQUEST);
print "&lt;/pre&gt;";
?&gt;</code></pre>
So, let's test it:
<pre><code>cerdo ~ $ curl -d 'name=david&amp;skill=lousy' http://localhost:82/damog/php/myscript.php?arg1=1
&lt;pre&gt;Array
(
[arg1] =&gt; 1
[name] =&gt; david
[skill] =&gt; lousy
)
&lt;/pre&gt;
cerdo ~ $ cat /tmp/myexample
arg1 -&gt; 1
skill -&gt; lousy
name -&gt; david
cerdo ~ $</code></pre>
As you can see, I'm sending both POST and GET parameters with curl. PHP displays it just fine, but also my temporary test file.

How are you using PerlCleanupHandler?