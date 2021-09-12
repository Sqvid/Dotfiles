#
# ███████╗░██████╗██╗░░██╗
# ╚════██║██╔════╝██║░░██║
# ░░███╔═╝╚█████╗░███████║
# ██╔══╝░░░╚═══██╗██╔══██║
# ███████╗██████╔╝██║░░██║
# ╚══════╝╚═════╝░╚═╝░░╚═╝
#

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
	autojump
)

source ${ZSH}/oh-my-zsh.sh


# *****************************************************************************
# Variables and Options:

# Exported variables:
userpath=${HOME}/bin
texpath=/opt/texlive/2021/bin/x86_64-linux
export GOPATH=${HOME}/Documents/Code/Go/libs
export PATH=${PATH}:${userpath}:${GOPATH}/bin:${texpath}

export EDITOR='nvim'
export VISUAL=${EDITOR}
export BROWSER=/usr/bin/firefox-wayland
export XDG_CONFIG_HOME="${HOME}/.config"
export FZF_DEFAULT_PREVIEW="bat --color=always --style=header,grid -r :300"

# Zsh options:
export KEYTIMEOUT=1
setopt EXTENDED_GLOB
setopt NO_AUTO_CD

# Bindkeys:
bindkey -v
bindkey "^?" backward-delete-char
bindkey "M-l" forward-char
bindkey "M-w" forward-word
bindkey '^R' history-incremental-search-backward
bindkey -s '^o' 'lfcd\n'


# *****************************************************************************
# Aliases:
alias ccc='gcc -Wall -Wextra -Wpedantic -std=c99'
alias please='sudo $(fc -ln -1)'
alias gdb='gdb --tui'
alias info='info --vi-keys'
alias shutdown='sudo poweroff'
alias restart='sudo reboot'
alias git='hub'
alias ranger='source ranger'
alias rngr='source ranger'
alias lff='lfcd'
alias vpm='vpm --color=yes'


# *****************************************************************************
# Functions:

# Notify when command is done.
msg() {
	echo "$@"
	if [ "$1" == "sudo" || "$1" ]; then
		programName=$2
	else
		programName=$1
	fi

	"$@" && notify-send "${programName} has finished!"
}

# Edit a file with $EDITOR.
v() {
	local viSelection;
	viSelection="$(find ./ -type f ! -iwholename "*.git/*" | fzf \
			--preview="${FZF_DEFAULT_PREVIEW} {}")"

	if [[ -n ${viSelection} ]]; then
		${EDITOR} "${viSelection}"
	fi
}

# Open a PDF with Zathura.
z() {
	local pdfSelection;
	pdfSelection="$(find ./ -type f -iname "*.pdf" | fzf \
			--preview='pdftotext -f 1 -l 3 {} -')"

	if [[ -n ${pdfSelection} ]]; then
		setsid -f zathura "${pdfSelection}"
	fi
}

# cd to a searched directory.
leap() {
	local dirSelection;
	dirSelection="$(find ./ -type d ! -iwholename "*.git/*" | fzf \
			--query="$1")"

	if [[ -n ${dir}Selection ]]; then
		cd "${dir}Selection" || return
	fi
}

# Edit a dotfile.
dot() {
	local dotSelection;
	dotSelection="$(find ${HOME}/.Dotfiles -type f ! -iwholename "*.git/*" \
			! -iwholename "*/plugged/*" -printf "%P\n" \
			| fzf --preview="${FZF_DEFAULT_PREVIEW} ~/.Dotfiles/{}"\
			--query="$1")"

	if [[ -n ${dotSelection} ]]; then
		${EDITOR} ~/.Dotfiles/"${dotSelection}"
	fi
}

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="${tmp}" "$@"
	if [ -f "${tmp}" ]; then
	dir="$(cat "${tmp}")"
	rm -f "${tmp}"
	[ -d "${dir}" ] && [ "${dir}" != "$(pwd)" ] && cd "${dir}" || return
	fi
}

btrsnap() {
	if [ $# -ne 1 ]; then
		echo "Must provide 'home' or 'root' as options."
	elif [[ "$1" == "root" ]]; then
		sudo btrfs subvolume snapshot / /snapshots/root/snapshot-root_$(date +%Y-%m-%d-%T)
	elif [[ "$1" == "home" ]]; then
		sudo btrfs subvolume snapshot /home /snapshots/home/snapshot-home_$(date +%Y-%m-%d-%T)
	else
		echo "Must provide 'home' or 'root' as options."
	fi
}


# *****************************************************************************
# Launch Programs:

# Window Manager:
if [[ "${TTY}" == "/dev/tty1" ]]; then
	echo "Launching Sway..."
	sleep 2
	dbus-run-session sway --my-next-gpu-wont-be-nvidia
fi
