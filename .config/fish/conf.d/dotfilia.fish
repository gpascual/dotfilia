alias dots='/usr/bin/git --git-dir=$HOME/.local/dotfilia.git/ --work-tree=$HOME'
alias dots-untrack-fish-variables='dots update-index --assume-unchanged $HOME/.config/fish/fish_variables'
alias dots-track-fish-variables='dots update-index --no-assume-unchanged $HOME/.config/fish/fish_variables'

dots-untrack-fish-variables

