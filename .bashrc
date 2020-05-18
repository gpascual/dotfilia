#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '

# source bash configs and stuff
for f in $HOME/.config/bash.d/*.bash; do source $f; done

# broot
source /home/gonzalo/.config/broot/launcher/bash/br

