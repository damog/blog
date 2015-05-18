Title: Running find with two or more commands to -exec
Date: 2010-09-28 12:02:38
Tags: bash,find,tips,unix

I spent a couple of minutes today trying to understand how to make <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?find" target="_blank"><tt>find (1)</tt></a> to execute two commands on the same target.

Instead of this or any similar crappy variants:

<code lang="bash">$ find . -type d -iname "*0" -mtime +60 -exec scp -r -P 1337 "{}" "meh.server.com:/mnt/1/backup/storage" && rm -rf "{}" \;</code>

Try something like this:

<code lang="bash">$ find . -type d -iname "*0" -mtime +60 -exec scp -r -P 1337 "{}" "meh.server.com:/mnt/1/backup/storage" \; -exec rm -rf "{}" \;</code>

Which is:

<code lang="bash">$ find . -exec command {} \; -exec other command {} \;</code>

And you're good to go.