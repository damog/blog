title: "Setting uid on God processes"
date: 2010/1/20 15:36:32
Tags: environment variables,god,processes,ruby,ssh,sysadmin
---
<p>I spent some minutes today at work figuring out why a script we use for files and assets propagation wasn't working when fired up under <a href="http://god.rubyforge.org/">God</a>, but it actually was working when run as its normal user.</p>
<p>The script is a <a href="http://www.sinatrarb.com">Sinatra</a> application that, upon pings/requests, connects through SSH to different servers on our clusters and execute commands. Details on the implementation are irrelevant here. Since this is automatized, we use key files for the SSH authentication.</p>
<p>When the script was running as the regular user, everything was working fine, but it wasn't under root. So I figured, <a href="http://net-ssh.rubyforge.org/ssh/v2/api/">Net::SSH</a> was trying to use root's private keys file. After reading God's examples I found out that you can also set uid and gid on the watched processes, so that's what I configured:</p>

<code lang="ruby">
 w.uid = "myuser"
 w.gid = "myuser"
</code>

<p>However, this was still not working. So I made the script print some verification:</p>

<code lang="ruby">
puts "My uid is: #{Process.uid} and euid: #{Process.euid} and user: #{ENV['USER']}"
</code>

<p>So <tt>Process.uid</tt> and <tt>Process.euid</tt> was correctly printing the UID for &quot;myuser&quot;, but ENV['USER'] was still &quot;root&quot;. I figured that ENV[&quot;HOME&quot;] would be the home directory based on the user, &quot;/root&quot;, so maybe Net::SSH was still trying to read <tt>/root/.ssh/id_rsa</tt>, and it was, quoting Net::SSH's :keys option:</p>
<blockquote>
<p>
<meta charset="utf-8">
<table class="list" style="margin-top: 2em; margin-right: 2em; margin-bottom: 2em; margin-left: 2em; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-top-color: black; border-right-color: black; border-bottom-color: black; border-left-color: black; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(255, 255, 221); padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; -webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: 0px; background-position: initial initial; background-repeat: initial initial; ">
    <tbody>
        <tr>
            <td style="padding-top: 0.2em; padding-right: 0.2em; padding-bottom: 0.2em; padding-left: 0.2em; text-align: center; vertical-align: top; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: initial; "><code>:keys</code></td>
            <td style="padding-top: 0.2em; padding-right: 0.2em; padding-bottom: 0.2em; padding-left: 0.2em; text-align: left; vertical-align: top; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: initial; ">This specifies the list of private key files to use&nbsp;<em>instead</em>&nbsp;of the defaults (<code>$HOME/.ssh/id_dsa</code>,&nbsp;<code>$HOME/.ssh2/id_dsa</code>,&nbsp;<code>$HOME/.ssh/id_rsa</code>, and&nbsp;<code>$HOME/.ssh2/id_rsa</code>). The value of this option should be an array of strings.</td>
        </tr>
    </tbody>
</table>
</meta>
</p>
</blockquote>
<p>God correctly runs the process with the given uid/gid but it will not change your environment variables. And there's nothing wrong with it, all generated processes on Unix systems will inherit its parent's set of variables. God shouldn't necessarily have to be different, but in case you mess around with a given user's environment variables on a process watched by God, remember this post :-)</p>