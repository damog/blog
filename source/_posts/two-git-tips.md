Title: Two Git tips
Date: 2008-12-12 23:52:28
Tags: git,tips
---
Following the Git tips being thrown on <a href="http://planet.debian.org">Planet Debian</a>, here's a couple:

<strong>1.</strong> Changing into a directory that contains a repo and shows you on PS1 what branch you are standing on:

<div align="center"><a href="http://damog.net/old/axiombox/2008/12/git-ps1.png"><img class="aligncenter size-full wp-image-739" title="git-ps1" src="http://damog.net/old/axiombox/2008/12/git-ps1.png" alt="" width="344" height="126" /></a></div>

On .bashrc I have:
<pre>GITPS1='$(__git_ps1 ":%s ")'
export PS1="${GREEN}\w${RS} ${YELLOW}${GITPS1}${RS}\\$ "</pre>
<strong>2.</strong> An alias I like to use on repos that are personal for quick tracking:

<div align="center"><a href="http://damog.net/old/axiombox/2008/12/git-log1.png"><img class="aligncenter size-full wp-image-740" title="git-log1" src="http://damog.net/old/axiombox/2008/12/git-log1.png" alt="" width="328" height="100" /></a></div>

<pre>[alias]
  ...
  log1 = log --pretty=oneline --abbrev-commit</pre>
I hope you like them.