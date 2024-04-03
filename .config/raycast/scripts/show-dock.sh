#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Dock
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/dock-icon.png

# Documentation:
# @raycast.description Show / hide dock

delay=$(defaults read com.apple.dock autohide-delay 2>/dev/null)

if [ "$delay" -eq 1000 ] >/dev/null 2>&1 ; then
    defaults write com.apple.dock autohide -bool false
    defaults delete com.apple.dock autohide-delay
    defaults write com.apple.dock no-bouncing -bool FALSE
else
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 1000
    defaults write com.apple.dock no-bouncing -bool TRUE
fi
# Restart Dock
killall Dock >/dev/null 2>&1
