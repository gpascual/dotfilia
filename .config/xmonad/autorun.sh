#!/usr/bin/env bash

. $XMONAD_CONFIG_HOME/autorun-functions

# XDG desktop portal backend
#run_once /usr/lib/xdg-desktop-portal
#run_once /usr/lib/xdg-desktop-portal-gtk --replace

# polkit agent
run_once /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Compositing
run_once picom -b --log-level WARN --log-file /tmp/picom_${USER}

# System tray
$(sleep 1; replace xmonad-stalonetray >> /tmp/stalonetray_$USER 2>&1) & # the 1s delay practically ensures stalonetray is run after xmobar so it stays over it

# Hotkeys daemon
run_once sxhkd

# Clipboard daemon
run_once clipmenud

# Set a random background periodically
replace nitrogen-folder $XDG_DATA_HOME/backgrounds/black_and_white_architecture/ 15m

# Third party Applets and Widgets
run_once nm-applet                          # network
run_once pa-applet                          # audio controls
run_once pasystray -m 100 -i 1 --notify=new # audio controls
systemctl is-active --quiet bluetooth \
  && run_once blueman-applet                # bluetooth

# Startup apps
run_once jetbrains-toolbox --minimize %u
run_once conky -c $HOME/.config/conky/xmonad.conkyrc

# Run other programs from files inside autorun.d folder
if [ -d $XMONAD_CONFIG_HOME/autorun.d ] ; then
  for f in $XMONAD_CONFIG_HOME/autorun.d/?[!.]* ; do
    . "$f"
  done
  unset f
fi

