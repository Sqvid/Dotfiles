# *****************************************************************************
# Oh My Zsh Configuration:

# Path to the Oh My Zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set Oh My Zsh theme.
ZSH_THEME="agnoster-short"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh plugins.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# *****************************************************************************
# Variables and Options:

# Exported variables:
export PATH=$PATH:~/bin:~/.local/bin:/usr/local/bin
export EDITOR='nvim'
export VISUAL=$EDITOR
export XDG_CONFIG_HOME="${HOME}/.config/"
export KEYTIMEOUT=1
export FZF_DEFAULT_PREVIEW="bat --color=always --style=header,grid -r :300"
export GOPATH=~/Documents/Code/Go

# Zsh options:
setopt EXTENDED_GLOB
setopt NO_AUTO_CD

# Bindkeys:
bindkey -v
bindkey "^?" backward-delete-char
bindkey "M-l" forward-char
bindkey "M-w" forward-word
bindkey '^R' history-incremental-search-backward


# *****************************************************************************
# Aliases:
#alias vi='nvim'
#alias vim='nvim'
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
alias dots='cd ~/.Dotfiles'
alias aulog='less /var/log/dnfupdate.log'
alias ccc='gcc -Wall -Wextra -Wpedantic -std=c99'
alias sdu='sudo dnf upgrade'
alias sdi='sudo dnf install'
alias ds='dnf search'


# *****************************************************************************
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

function leap() {
	local dirSelection;
	dirSelection="$(find ./ -type d ! -iwholename "*.git/*" | fzf)"

	if [[ -n $dirSelection ]]; then
		cd "$dirSelection"
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
