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
DISABLE_MAGIC_FUNCTIONS="true"

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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting copypath dirbrowse extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias cat="bat -p -P"
alias ls="eza --icons --group-directories-first"
alias ll="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first -a"
alias tree="eza --tree --icons"
alias vi="nvim"
alias htop="btm -b --color gruvbox"
alias man="batman"
alias diff="batdiff"
alias joplin="joplin --profile $HOME/.config/joplin-desktop 2> /dev/null"
alias -g errout="2>&1 >/dev/null"

# Functions
lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}
alias lf="lfcd"

imgview() {
    command chafa -f iterm --optimize=9 --animate off --polite on "$@"
}

tgptf() {
    local content
    if [ -t 0 ]; then content=$(cat "$1") else content=$(cat) fi
    content="${content}"$'\n'
    tgpt -preprompt "$content" -m
}

joplexp() {
    find ~/Documents/notes -mindepth 1 -maxdepth 1 -type d -exec rm -r {} +
    joplin export ~/Documents/notes --format md
    printf "%s\n" "Joplin notes exported to ~/Documents/notes"
}

mdtopdf() {
    (pandoc -f gfm -t html5 --css ~/Documents/notes/github.css "$1" -o ~/Documents/notes/output.pdf 2> /dev/null | zathura - &)
}

# Updater for installation using the installer script
# Brew installation is not recommended, as it requires regranting permissions at every update
yabai-update() {
    yabai --stop-service
    curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin
    echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
    yabai --start-service
}

cpprun() {
    g++-14 -std=c++20 "$@" && ./a.out && rm ./a.out
}

qcpp() {
    cp ~/Documents/projects/leetcode/template.cpp "$1" && nvim "$1"
}

export BAT_THEME=gruvbox-dark

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fzf shell integration.
source <(fzf --zsh)

[ -f ~/.config/fzfscripts.sh ] && source ~/.config/fzfscripts.sh

# Perl configuration
PATH="/Users/gioel/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/gioel/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/gioel/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/gioel/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/gioel/perl5"; export PERL_MM_OPT;
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

