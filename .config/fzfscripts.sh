# -----------------------------------------------------------
# Default key binds
# -----------------------------------------------------------
 
# Vim-like half-page navigation
export FZF_DEFAULT_OPTS='--bind "ctrl-d:half-page-down,ctrl-u:half-page-up"'

# -----------------------------------------------------------
# Helper functions
# -----------------------------------------------------------

# Prints the help message for crange
helper_crange() {
  printf "%s\n" "Interactively select and print a range of lines from a file."
  printf "%s\n\n" "Use Tab to select a line in the fzf previewer, use Enter to confirm the selection."
  printf "\033[1m\033[4m%s\033[0m %s\n" "Usage:" "crange FILE"
}

# Prints the help message for fline
helper_fline() {
  printf "%s\n" "Interactively search lines from files."
  printf "%s\n\n" "Use Enter in the fzf previewer to select a file and open it at the highlighted line in VSCode."
  printf "\033[1m\033[4m%s\033[0m %s\n\n" "Usage:" "fline [OPTIONS] [PATTERN] [DIRECTORY...]"
  printf "\033[1m\033[4m%s\033[0m\n" "Arguments:"
  printf "  %s          %s\n" "[PATTERN]" "The search pattern (a literal string, unless '--regex' is used; optional)"
  printf "  %s    %s\n\n" "[DIRECTORY ...]" "The directories where to start the search (optional)"
  printf "\033[1m\033[4m%s\033[0m\n" "Options:"
  printf "  %s, %s           %s\n" "-h" "--help" "Display this help message and exit."
  printf "  %s, %s         %s\n" "-H" "--hidden" "Search hidden files and directories."
  printf "  %s, %s          %s\n" "-r" "--regex" "Enable regular expression mode for search (default: fixed string)."
  printf "  %s, %s      %s\n" "-n" "--no-ignore" "Do not respect .gitignore or any ignore files."
}

helper_fdir() {
  printf "%s\n" "Find and change directory interactively."
  printf "%s\n\n" "Use Enter in the fzf previewer to change to that directory."
  printf "\033[1m\033[4m%s\033[0m %s\n\n" "Usage:" "fdir [OPTIONS] [PATTERN] [DIRECTORY...]"
  printf "\033[1m\033[4m%s\033[0m\n" "Arguments:"
  printf "  %s          %s\n" "[PATTERN]" "The search pattern (a literal string, unless '--regex' is used; optional)"
  printf "  %s    %s\n\n" "[DIRECTORY ...]" "The directories where to start the search (optional)"
  printf "\033[1m\033[4m%s\033[0m\n" "Options:"
  printf "  %s, %s           %s\n" "-h" "--help" "Display this help message and exit."
  printf "  %s, %s         %s\n" "-H" "--hidden" "Search hidden files and directories."
  printf "  %s, %s          %s\n" "-r" "--regex" "Enable regular expression mode for search (default: fixed string)."
  printf "  %s, %s      %s\n" "-n" "--no-ignore" "Do not respect .gitignore or any ignore files."
}

# Prints the help message for ffile
helper_ffile() {
  printf "%s\n" "Interactively find a file."
  printf "%s\n\n" "Use Enter in the fzf previewer to select a file and open it in VSCode."
  printf "\033[1m\033[4m%s\033[0m %s\n\n" "Usage:" "ffile [OPTIONS] [PATTERN] [DIRECTORY...]"
  printf "\033[1m\033[4m%s\033[0m\n" "Arguments:"
  printf "  %s          %s\n" "[PATTERN]" "The search pattern (a literal string, unless '--regex' is used; optional)"
  printf "  %s    %s\n\n" "[DIRECTORY ...]" "The directories where to start the search (optional)"
  printf "\033[1m\033[4m%s\033[0m\n" "Options:"
  printf "  %s, %s           %s\n" "-h" "--help" "Display this help message and exit."
  printf "  %s, %s         %s\n" "-H" "--hidden" "Search hidden files and directories."
  printf "  %s, %s          %s\n" "-r" "--regex" "Enable regular expression mode for search (default: fixed string)."
  printf "  %s, %s      %s\n" "-n" "--no-ignore" "Do not respect .gitignore or any ignore files."
}

# Handles the arguments passed to the script
handle_args() {
  if [ -z "$args" ]; then
    args="\"$1\""
  elif [ -d "$1" ]; then
      args="$args \"$1\""
  else
    printf "%s: %s: %s\n" "$0" "$1" "Not a valid directory name" >&2
    return 1
  fi
}

# -----------------------------------------------------------
# Main functions
# -----------------------------------------------------------

# Interactively find a file and open it in VSCode
ffile() {
  fd_opts="--color=always --type=file --follow"
  args=""
  use_fixed_strings=true
  # Iterate through arguments and build command
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help) helper_ffile; return;;
      -r|--regex) use_fixed_strings=false; shift;;
      -n|--no-ignore) fd_opts="$fd_opts --no-ignore"; shift;;
      -H|--hidden) fd_opts="$fd_opts --hidden"; shift;;
      *) handle_args "$1" || return 1; shift;;
    esac
  done
  if [ $use_fixed_strings = true ]; then fd_opts="$fd_opts --fixed-strings"; fi
  if [ -z "$args" ]; then fd_opts="$fd_opts \"\""; else fd_opts="$fd_opts $args"; fi
  fd_cmd="fd $fd_opts"
  eval "$fd_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --preview '~/.config/lf/preview {} ${FZF_PREVIEW_COLUMNS} ${FZF_PREVIEW_LINES}' \
      --bind 'enter:execute-silent(code --goto {})+accept' > /dev/null
}

# Interactively find and cd to a directory
fdir() {
  fd_opts="--color=always --type=directory --follow"
  args=""
  use_fixed_strings=true
  # Iterate through arguments and build command
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help) helper_fdir; return;;
      -r|--regex) use_fixed_strings=false; shift;;
      -n|--no-ignore) fd_opts="$fd_opts --no-ignore"; shift;;
      -H|--hidden) fd_opts="$fd_opts --hidden"; shift;;
      *) handle_args "$1" || return 1; shift;;
      esac
  done
  if [ $use_fixed_strings = true ]; then fd_opts="$fd_opts --fixed-strings"; fi
  # Build pattern and base dir path
  if [ -z "$args" ]; then fd_opts="$fd_opts \"\""; else fd_opts="$fd_opts $args"; fi
  fd_cmd="fd $fd_opts"
  dir="$(eval "$fd_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview-window 'up,40%,border-bottom,+{2}+3/3,~3' \
      --preview 'eza --icons --color=always --group-directories-first {}')"
  cd "$dir" 
}

# Interactively find a line in files and open it in VSCode
fline() {
  rg_opts="--color=always --line-number --no-heading --follow"
  args=""
  use_fixed_strings=true
  # Iterate through arguments and build command
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help) helper_fline; return;;
      -r|--regex) use_fixed_strings=false; shift;;
      -n|--no-ignore) rg_opts="$rg_opts --no-ignore"; shift;;
      -H|--hidden) rg_opts="$rg_opts --hidden"; shift;;
      *) handle_args "$1" || return 1; shift;;
    esac
  done
  if [ $use_fixed_strings = true ]; then rg_opts="$rg_opts --fixed-strings --smart-case"; fi
  if [ -z "$args" ]; then rg_opts="$rg_opts \"\""; else rg_opts="$rg_opts $args"; fi
  rg_cmd="rg $rg_opts"
  # Execute command and pipe it into fzf
  eval "$rg_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:execute-silent(code --goto {1}:{2})+accept' > /dev/null
}

# Interactively selects a range of lines from a text file and prints all lines in the range
crange() {
  # Print help message
  for arg in "$@"; do if [ "$arg" = "-h" ] || [ "$arg" = "--help" ]; then helper_crange; return; fi; done
  # Select lines
  if sr=$(bat --color=always -n "$1"); then
    if [ -z "$sr" ]; then return; fi
    sr=$(printf "%s" "$sr" | fzf --ansi -m -e --reverse | awk '{print $1}' | sort -n)
    minl=$(printf "%s" "$sr" | head -n 1)
    maxl=$(printf "%s" "$sr" | tail -n 1)
    if [ -z "$minl" ] || [ -z "$maxl" ]; then return; fi
    sed -n "${minl},${maxl}p" "$1"  
  fi
}