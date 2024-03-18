fastfetch
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting copypath dirbrowse extract history)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias cat="bat -p -P"
alias ls="eza --icons --group-directories-first"
alias ll="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first -a"
alias man="batman"
alias diff="batdiff"
alias -g errout="2>&1 >/dev/null"

# Functions
lfcd () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
    # Avoid registering error exit status
    return 0
}
alias lf="lfcd"

imgview() {
    command chafa -f sixel --optimize=9 --animate off --polite on "$@"
}

tgptf() {
    local content
    if [ -t 0 ]; then content=$(cat "$1") else content=$(cat) fi
    content="${content}"$'\n'
    tgpt -preprompt "$content" -m
}

source ~/.config/fzfscripts.zsh

export BAT_THEME=gruvbox-dark

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Forgit configuration
# Homebrew installation, for Linux install as ohmyzsh plugin instead
export FORGIT_PAGER="delta --navigate -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS} --wrap-max-lines 2"
export FORGIT_FZF_DEFAULT_OPTS="--height='100%' --color 'hl:-1:underline,hl+:-1:underline:reverse' --preview-window 'up,40%,border-bottom,+{2}+3/3,~3'"
export FORGIT_BLAME_PAGER="delta --navigate --hyperlinks"
export FORGIT_DIFF_PAGER="delta --navigate --side-by-side --line-numbers-right-format='│ ' -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS} --wrap-max-lines 2"
export FORGIT_DIFF_FZF_OPTS="--preview-window 'up,80%,border-bottom,+{2}+3/3,~3'" 
export FORGIT_ADD_FZF_OPTS="--preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"
export FORGIT_LOG_FZF_OPTS="--preview-window 'up,50%,border-bottom,+{2}+3/3,~3'"
export FORGIT_CHECKOUT_FILE_FZF_OPTS="--preview-window 'up,75%,border-bottom,+{2}+3/3,~3'" 
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS="--list"
export FORGIT_CHECKOUT_BRANCH_FZF_OPTS="--preview-window 'up,35%,border-bottom,+{2}+3/3,~3'"
export FORGIT_BRANCH_DELETE_FZF_OPTS=""

[ -f /usr/local/opt/forgit/share/forgit/forgit.plugin.zsh ] && source /usr/local/opt/forgit/share/forgit/forgit.plugin.zsh

export PATH="$PATH:~/local/bin"
