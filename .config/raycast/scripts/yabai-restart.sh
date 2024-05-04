#!/bin/dash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai restart
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai-icon.png

# Documentation:
# @raycast.description Restart yabai daemon

if ! yabai --restart-service >/dev/null 2>&1; then
    yabai --start-service >/dev/null 2>&1
fi
