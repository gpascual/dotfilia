alias dotfilia='/usr/bin/git --git-dir=$HOME/.local/.dotfilia.git/ --work-tree=$HOME'
alias dotfilia-untrack-fish-variables='dotfilia update-index --assume-unchanged $HOME/.config/fish/fish_variables'
alias dotfilia-track-fish-variables='dotfilia update-index --no-assume-unchanged $HOME/.config/fish/fish_variables'

dotfilia-untrack-fish-variables

