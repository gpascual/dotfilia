alias dotfilia='/usr/bin/git --git-dir=/home/gonzalo/.local/.dotfilia.git/ --work-tree=/home/gonzalo'
alias dotfilia-untrack-fish-variables='dotfilia update-index --assume-unchanged $HOME/.config/fish/fish_variables'
alias dotfilia-track-fish-variables='dotfilia update-index --no-assume-unchanged $HOME/.config/fish/fish_variables'

dotfilia-untrack-fish-variables

