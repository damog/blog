---
title: "Disable Nginx logging"
date: 2011-03-24 14:47:07
tag:
- http
- nginx
- tips
---
This is something that is specified clearly on the <a href="http://wiki.nginx.org/Modules#Nginx_core_modules">Nginx manual</a>, but it's nice to have it as a quick reference.

The `access_log` and `error_log` directives on Nginx are on separate modules (<a href="http://wiki.nginx.org/HttpLogModule">HTTP Log</a> and <a href="http://wiki.nginx.org/CoreModule">Core</a> modules respectively) and they don't behave the same way when all you want is to disable all logging on your server (in our case, <a href="http://nabbr.com/">we</a> serve a gazillion static files and perform a lot of reverse proxying and we're not interested on tracking that). It's a common misconception that you can set `error_log` to off, because that's how you disable `access_log` (if you do that, the server will still log to the file `$nginx_path/off`). Instead, you have to set `error_log` to log to the always mighty black hole `/dev/null` using the highest level for logging (which triggers the fewest events), `crit`:

    http {
      server {
        # ...
        access_log off;
        error_log /dev/null crit;
        # ...
      }
      #...
    }

If you're the possessor of the blingest of bling-bling, you can disable all logging (not only for a server block), by putting `error_log` on the root of the configuration and `access_log` within your http block and make sure you don't override that on any of the inner blocks. And you're good to go.
