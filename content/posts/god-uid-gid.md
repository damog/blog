---
title: "Setting uid on God processes"
date: 2010-01-20 15:36:32
tag:
- environment variables
- god
- processes
- ruby
- ssh
- sysadmin
---
I spent some minutes today at work figuring out why a script we use for files and assets propagation wasn't working when fired up under [God](http://godrb.com/), but it actually was working when run as its normal user.

The script is a [Sinatra](http://www.sinatrarb.com) application that, upon pings/requests, connects through SSH to different servers on our clusters and execute commands. Details on the implementation are irrelevant here. Since this is automatized, we use key files for the SSH authentication.

When the script was running as the regular user, everything was working fine, but it wasn't under root. So I figured, [Net::SSH](http://www.rubydoc.info/github/net-ssh/net-ssh/Net/SSH) was trying to use root's private keys file. After reading God's examples I found out that you can also set uid and gid on the watched processes, so that's what I configured:

     w.uid = "myuser"
     w.gid = "myuser"

However, this was still not working. So I made the script print some verification:

    puts "My uid is: #{Process.uid} and euid: #{Process.euid} and user: #{ENV['USER']}"

So `Process.uid` and `Process.euid` was correctly printing the UID for `myuser`, but `ENV['USER']` was still `root`. I figured that `ENV["HOME"]` would be the home directory based on the user, `/root`, so maybe `Net::SSH` was still trying to read `/root/.ssh/id_rsa`, and it was, quoting Net::SSH's `:keys` option:

> :keys     This specifies the list of private key files to use instead of the
>           defaults ($HOME/.ssh/id_dsa, $HOME/.ssh2/id_dsa, $HOME/.ssh/id_rsa,
>           and $HOME/.ssh2/id_rsa). The value of this option should be an array
>           of strings.

God correctly runs the process with the given uid/gid but it will not change your environment variables. And there's nothing wrong with it, all generated processes on Unix systems will inherit its parent's set of variables. God shouldn't necessarily have to be different, but in case you mess around with a given user's environment variables on a process watched by God, remember this post :-)
