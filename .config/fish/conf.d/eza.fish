#
# exa
#

# Changing "ls" to "exa"
alias ls='eza --color=always --group-directories-first'     # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing

# Shortcuts
alias ezaG='eza -lG --icons --header --group-directories-first'     # grid view
alias ezaT='eza -lT --icons --header --group-directories-first -L2' # tree view

