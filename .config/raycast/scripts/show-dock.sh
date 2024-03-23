#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Dock
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

# Documentation:
# @raycast.description Show / hide dock

delay=$(defaults read com.apple.dock autohide-delay 2>/dev/null)

if [ "$delay" -eq 1000 ] >/dev/null 2>&1 ; then
    defaults write com.apple.dock autohide -bool false && killall Dock
    defaults delete com.apple.dock autohide-delay && killall Dock
    defaults write com.apple.dock no-bouncing -bool FALSE && killall Dock
else
    defaults write com.apple.dock autohide -bool true && killall Dock
    defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
    defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
fi
