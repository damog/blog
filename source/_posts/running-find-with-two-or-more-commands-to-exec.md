title: "Running find with two or more commands to -exec"
date: 2010/9/28 12:02:38
tags:
- bash
- find
- tips
- unix
---
I spent a couple of minutes today trying to understand how to make <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?find" target="_blank">`find (1)`</a> to execute two commands on the same target.

Instead of this or any similar crappy variants:

    $ find . -type d -iname "*0" -mtime +60 -exec scp -r -P 1337 "{}" "meh.server.com:/mnt/1/backup/storage" && rm -rf "{}" \;

Try something like this:

    $ find . -type d -iname "*0" -mtime +60 -exec scp -r -P 1337 "{}" "meh.server.com:/mnt/1/backup/storage" \; -exec rm -rf "{}" \;

Which is:

    $ find . -exec command {} \; -exec other command {} \;

And you're good to go.
