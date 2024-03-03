#!/bin/zsh

# -----------------------------------------------------------
# Default key binds
# -----------------------------------------------------------
 
# Vim-like half-page navigation
export FZF_DEFAULT_OPTS='--bind "ctrl-d:half-page-down,ctrl-u:half-page-up"'

# -----------------------------------------------------------
# Help messages
# -----------------------------------------------------------
 
declare -A helper_map
helper_map[crange]="Interactively select and print a range of lines from a file.
Use Tab to select a line in the fzf previewer, use Enter to confirm the selection.\n
\033[1m\033[4mUsage:\033[0m crange FILE"
helper_map[fline]="Interactively search lines from files.
Use Enter in the fzf previewer to select a file and open it at the highlighted line in VSCode.\n
\033[1m\033[4mUsage:\033[0m fline [OPTIONS] [PATTERN] [DIRECTORY]\n
\033[1m\033[4mArguments:\033[0m
  [PATTERN]     The search pattern (a literal string, unless '--regex' is used; optional)
  [DIRECTORY]   The root directory for the filesystem search (optional)
\n\033[1m\033[4mOptions:\033[0m
  -h, --help           Display this help message and exit.
  -H, --hidden         Search hidden files and directories.
  -r, --regex          Enable regular expression mode for search (default: fixed string).
  -n, --no-ignore      Do not respect .gitignore or any ignore files.
"
helper_map[fdir]="Find and change directory interactively.
Use Enter in the fzf previewer to change to that directory.\n
\033[1m\033[4mUsage:\033[0m fdir [OPTIONS] [PATTERN] [DIRECTORY]\n
\033[1m\033[4mArguments:\033[0m
  [PATTERN]     The search pattern (a literal string, unless '--regex' is used; optional)
  [DIRECTORY]   The root directory for the filesystem search (optional)
\n\033[1m\033[4mOptions:\033[0m
  -h, --help           Display this help message and exit.
  -H, --hidden         Search hidden files and directories.
  -r, --regex          Enable regular expression mode for search (default: fixed string).
  -n, --no-ignore      Do not respect .gitignore or any ignore files.
"
helper_map[ffile]="Interactively find a file.
Use Enter in the fzf previewer to select a file and open it in VSCode.\n
\033[1m\033[4mUsage:\033[0m ffile [OPTIONS] [PATTERN] [DIRECTORY]\n
\033[1m\033[4mArguments:\033[0m
  [PATTERN]     The search pattern (a literal string, unless '--regex' is used; optional)
  [DIRECTORY]   The root directory for the filesystem search (optional)
\n\033[1m\033[4mOptions:\033[0m
  -h, --help           Display this help message and exit.
  -H, --hidden         Search hidden files and directories.
  -r, --regex          Enable regular expression mode for search (default: fixed string).
  -n, --no-ignore      Do not respect .gitignore or any ignore files.
"

# -----------------------------------------------------------
# Functions
# -----------------------------------------------------------

custom_preview() {
    case "$(file --dereference --brief --mime-type -- "$1")" in
      image/*)
        echo image ;;
      *)
        echo text ;;
    esac
}

# Interactively find a file and open it in VSCode
ffile() {
  local fd_opts
  fd_opts=("--color=always" "--type=file" "--follow")
  local args
  args=()
  local use_glob_strings=true
  # Iterate through arguments and build command
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help) echo "${helper_map[ffile]}"; return;;
      -r|--regex) use_glob_strings=false; shift;;
      -n|--no-ignore) fd_opts+=("--no-ignore"); shift;;
      -H|--hidden) fd_opts+=("--hidden"); shift;;
      *) args+=("$1"); shift;;
    esac
  done
  if $use_glob_strings; then fd_opts+=("--fixed-strings") fi
  # Build pattern and base dir path
  if [[ "${#args[@]}" -gt 0 ]]; then
    fd_opts+=("\"${args[1]}\"")
    if [[ "${#args[@]}" -gt 1 && -d "${args[2]}" ]]; then fd_opts+=("\"${args[2]}\"")
    elif [[ "${#args[@]}" -gt 1 ]]; then echo "Error: Second argument is not a valid directory name." >&2; return 1
    fi
  else
    fd_opts+=("\"\"")  # Add literal string "" if no arguments provided
  fi
  local fd_cmd="fd ${fd_opts[*]}"
  eval "$fd_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --preview '~/.config/lf/preview {} ${FZF_PREVIEW_COLUMNS} ${FZF_PREVIEW_LINES}' \
      --bind 'enter:execute-silent(code --goto {})+accept'
}

# Interactively find and cd to a directory
fdir() {
  local fd_opts
  fd_opts=("--color=always" "--type=directory" "--follow")
  local args
  args=()
  local use_glob_strings=true
  # Iterate through arguments and build command
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help) echo "${helper_map[fdir]}"; return;;
      -r|--regex) use_glob_strings=false; shift;;
      -n|--no-ignore) fd_opts+=("--no-ignore"); shift;;
      -H|--hidden) fd_opts+=("--hidden"); shift;;
      *) args+=("$1"); shift;;
      esac
  done
  if $use_glob_strings; then fd_opts+=(""--fixed-strings"") fi
  # Build pattern and base dir path
  if [[ "${#args[@]}" -gt 0 ]]; then
    fd_opts+=("\"${args[1]}\"")
      if [[ "${#args[@]}" -gt 1 && -d "${args[2]}" ]]; then fd_opts+=("\"${args[2]}\"")
      elif [[ "${#args[@]}" -gt 1 ]]; then echo "Error: Second argument is not a valid directory name." >&2; return 1
      fi
  else
    fd_opts+=("\"\"")  # Add literal string "" if no arguments provided
  fi
  local fd_cmd="fd ${fd_opts[*]}"
  local dir="$(eval "$fd_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'eza --icons --color=always --group-directories-first {}' \
      --preview-window 'up,40%,border-bottom,+{2}+3/3,~3')"
    cd "$dir"
}

# Interactively find a line in files and open it in VSCode
fline() {
  local rg_opts
  rg_opts=("--color=always" "--line-number" "--no-heading" "--follow")
  local args
  args=()
  local use_fixed_strings=true
  # Iterate through arguments and build command
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help) echo "${helper_map[fline]}"; return;;
      -r|--regex) use_fixed_strings=false; shift;;
      -n|--no-ignore) rg_opts+=("--no-ignore"); shift;;
      -H|--hidden) fd_opts+=("--hidden"); shift;;
      *) args+=("$1"); shift;;
    esac
  done
  if $use_fixed_strings; then rg_opts+=("--fixed-strings" "--smart-case") fi
  # Build pattern and base dir path
  if [[ "${#args[@]}" -gt 0 ]]; then
    rg_opts+=("\"${args[1]}\"")
    if [[ "${#args[@]}" -gt 1 && -d "${args[2]}" ]]; then rg_opts+=("\"${args[2]}\"")
    elif [[ "${#args[@]}" -gt 1 ]]; then echo "Error: Second argument is not a valid directory name." >&2; return 1
    fi
  else
    rg_opts+=("\"\"")  # Add literal string "" if no arguments provided
  fi
  local rg_cmd="rg ${rg_opts[*]}"
  # Execute command and pipe it into fzf
  eval "$rg_cmd" 2>/dev/null |
  fzf --ansi -e \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:execute-silent(code --goto {1}:{2})+accept'
}

# Interactively selects a range of lines from a text file and prints all lines in the range
crange() {
  # Print help message
  for arg in "$@"; do if [[ "$arg" == "-h" || "$arg" == "--help" ]]; then echo "${helper_map[crange]}"; return; fi; done
  # Select lines
  local sr
  if sr=$(bat --color=always -n "$1"); then
    if [[ -z "$sr" ]]; then return; fi
    sr=$(printf "%s" "$sr" | fzf --ansi -m -e --reverse | awk '{print $1}' | sort -n)
    local minl=$(echo "$sr" | head -n 1)
    local maxl=$(echo "$sr" | tail -n 1)
    if [ -z "$minl" ] || [ -z "$maxl" ]; then return; fi
    sed -n "${minl},${maxl}p" "$1"  
  fi
}