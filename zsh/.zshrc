# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:~/bin:~/.local/bin:/usr/local/bin

# Path to your oh-my-zsh installation.
export ZSH="/home/siddhartha/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster-short"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Allow extended globbing pattern set.
setopt EXTENDED_GLOB

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

#Exported variables
export EDITOR='nvim'
export VISUAL=$EDITOR
export XDG_CONFIG_HOME="${HOME}/.config/"
export KEYTIMEOUT=1
export FZF_DEFAULT_PREVIEW="bat --color=always --style=header,grid \
				--line-range :300"

#Bindkeys:
bindkey -v
bindkey "^?" backward-delete-char
bindkey "M-l" forward-char
bindkey "M-w" forward-word
bindkey '^R' history-incremental-search-backward

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

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#Aliases
alias vi='nvim'
alias vim='nvim'
alias please='sudo $(fc -ln -1)'
alias music='cmus'
alias gdb='gdb --tui'
alias info='info --vi-keys'
alias restart='shutdown -r'
alias swayconfig='nvim ~/.config/sway/config'
alias sway='sway --my-next-gpu-wont-be-nvidia'
alias git='hub'
alias ranger='source ranger'
alias rngr='source ranger'
alias mkcd='source mkcd'
alias dots='cd ~/.Dotfiles'
alias aulog='less /var/log/dnfupdate.log'
alias ccc='gcc -Wall -Wextra -Wpedantic -std=c99'


# Functions:
function msg() {
	echo "$@"
	if [[ "$1" == "sudo" || "$1" ]]; then
		programName=$2
	else
		programName=$1
	fi

	"$@" && notify-send "$programName has finished!"
}

function v() {
	local viSelection;
	viSelection="$(find ./ -type f ! -iwholename "*.git/*" | fzf \
			--preview="$FZF_DEFAULT_PREVIEW {}")"

	if [[ -n $viSelection ]]; then
		$EDITOR "$viSelection"
	fi
}

function z() {
	local pdfSelection;
	pdfSelection="$(find ./ -type f -iname "*.pdf" | fzf \
			--preview='pdftotext -f 1 -l 3 {} -')"

	if [[ -n $pdfSelection ]]; then
		zathura "$pdfSelection" &
	fi
}

function dotconfig() {
	local dotSelection;
	dotSelection="$(find $HOME/.Dotfiles -type f ! -iwholename "*.git/*" \
			! -iwholename "*/plugged/*" -printf "%P\n" \
			| fzf --preview="$FZF_DEFAULT_PREVIEW ~/.Dotfiles/{}")"

	if [[ -n $dotSelection ]]; then
		$EDITOR ~/.Dotfiles/"$dotSelection"
	fi
}
