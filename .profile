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

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm.conf"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$HOME/.local"

# archlinux xdg_menu
export XDG_MENU_ROOT_MENU=$HOME/.config/xdg_menu/applications.menu

if [ -d $XDG_CONFIG_HOME/profile.d ] ; then
  for f in $XDG_CONFIG_HOME/profile.d/?[!.]* ; do
    . "$f"
  done
  unset f
fi
