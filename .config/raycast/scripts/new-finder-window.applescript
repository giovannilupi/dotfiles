#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Finder Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/finder-icon.png

# Documentation:
# @raycast.description Open new Finder window

tell application "Finder"
    make new Finder window to folder (path to home folder as text)
    do shell script "open -a Finder"
end tell
