#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Notes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/sublime-icon.png

# Documentation:
# @raycast.description Open notes in sublime

# Path to the notes
notes_path="$HOME/Documents/notes"

# Find the last line number of the file
last_line=$(awk 'END {print NR}' "$notes_path")

# Open the file in Sublime Text, focusing on the last line
subl "$notes_path":"$last_line"

