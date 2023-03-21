#
# exa
#

# Changing "ls" to "exa"
alias ls='exa --color=always --group-directories-first'     # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# Shortcuts
alias exaG='exa -lG --icons --header --group-directories-first'     # grid view
alias exaT='exa -lT --icons --header --group-directories-first -L2' # tree view

