#!/usr/bin/env bash

function run_once {
  if ! pidof $1 ;
  then
    $@&
  fi
}

function replace {
  killall -e $1
  $@&
}

# XDG desktop portal backend
#run_once /usr/lib/xdg-desktop-portal
#run_once /usr/lib/xdg-desktop-portal-gtk --replace

# polkit agent
run_once /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Compositing
run_once picom -b --log-file ~/.picom.log

# System tray
replace stalonetray --config ~/.config/stalonetrayrc

# Hotkeys daemon
run_once sxhkd

# Clipboard daemon
run_once clipmenud

# Third party Applets and Widgets
run_once nm-applet   # network
run_once pa-applet   # audio controls

# Startup apps
run_once jetbrains-toolbox --minimize %u

