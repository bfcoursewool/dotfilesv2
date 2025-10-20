#l Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

##################### ph-my-zsh configs ##########################

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colored-man-pages colorize history forklift taskwarrior yarn)

source $ZSH/oh-my-zsh.sh

# MCP Server vars
if [ -f ~/.dotfiles-secrets ]; then
  source ~/.dotfiles-secrets
fi
export DEFAULT_MINIMUM_TOKENS=6000


##################### User configs ###############################

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

# Path setup and initialization of starship, zoxide, etc. 
export GPG_TTY='tty'
export PINENTRY_USER_DATA="USE_CURSES=1"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:~/.local/bin:/usr/local/bin:/Users/robertkotz/go/bin:/opt/nvim-macos-arm64/bin:$HOME/.foundry/bin:/opt/homebrew/bin:$PATH"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
autoload -Uz compinit && compinit

# nvm path setup and initialization
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Where should I put you?
bindkey -s ^p "~/.local/bin/tmux-sessionizer\n"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# autosuggestions and syntax highlighting for the CLI... supah hella choke dope. 
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Start typing a command, and then up and down arrow keys will search through the command history
# of commands that match the starting characters you've typed... So `yarn<up arrow>` will search through
# previous `yarn` commands, etc.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
 
# Duh. 
export EDITOR="/opt/homebrew/bin/nvim"

# a little shortcut for running yazi
function Y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command bat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ----- Bat (better cat) -----
export BAT_THEME=fly16

# fzf setup -- check out @joseanmartinez on YT, he has a great video on fzf and more or less everything from here to the end of this
# file is sourced from there.
source <(fzf --zsh)

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

## Use fd instead of find with fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan} \
                         --bind=ctrl-k:preview-up,ctrl-j:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.config/fzf/fzf-git.sh/fzf-git.sh

#### Personal aliases ####

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Convenient k8s aliases
alias k="kubectl"
alias kx="kubectx"
alias kaf="kubectl apply -f "
alias kdf="kubectl delete -f "

# vim is the new vi, nvim is the new vim. duh. 
alias vi="/usr/bin/vim"
#alias vim="nvim"
alias vim="/opt/homebrew/bin/nvim"

# brew install / uninstall / search shortcuts cause why not
alias bi="brew install"
alias bu="brew uninstall"
alias bs="brew search"

# Grep with color is better
export GREP_COLORS='mt=1;35;40'
alias grep="grep --color"
alias egrep="egrep --color"

# Use colorized less
alias less="cless"

# mirroring the starship history plugin with hs and hsi, but for `dirs -v`
# but really, don't use this. <C-r> is integrated with fzf, and it's the better
# way to search your command history.
alias ds='d | grep'
alias dsi='d | grep -i'

# omz somehow misses this one I guess?
alias 0='cd -0'

# Common typos may as well just do what I want them to.
# But also don't use this... <C-l> is the way.
alias cledar="clear"

# eza is ls but with cool icons I guess. nice.
alias ls="eza --icons=always --git"
alias ll="ls -lh -snew -t changed"
alias la="ls -alh -snew -t changed"

# aliasing cd to use zoxide instead of coreutils cd
alias cd="z"

# similarly. aliasing cat to use bat cause it's just better
alias cat="bat"

# This deconflicts a yazi thing with some aliases that already exist from the
# yarn plugin from oh-my-zsh... `ya` already means `yarn add`, so yazi's `ya' 
# can't be `ya` anymore. Fortunately yazi's `ya` is not something I need to use
# and I've already forgotten whatever I needed to use it for in the first place, but
# in case something pops up in the future, it's `yza` now instead.
alias yza="/opt/homebrew/Cellar/yazi/25.4.8/bin/ya"
