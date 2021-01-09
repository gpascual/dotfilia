#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '

# source bash configs and stuff
if [ -d $XDG_CONFIG_HOME/bash.d ] ; then
 for f in $XDG_CONFIG_HOME/bash.d/?[!.]* ; do
  . "$f"
 done
 unset f
fi

# broot
source /home/gonzalo/.config/broot/launcher/bash/br

