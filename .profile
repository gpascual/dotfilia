#
# ~/.profile
#

export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
export VISUAL=nvim;
export EDITOR="$VISUAL";

#XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# composer
export COMPOSER_BIN_DIR="$HOME/.local/bin"
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm.conf"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$HOME/.local"

# archlinux xdg_menu
export XDG_MENU_ROOT_MENU=$HOME/.config/xdg_menu/applications.menu

