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

source "${ZSH}/oh-my-zsh.sh"


# *****************************************************************************
# Variables and Options:

# Starship prompt
#eval "$(starship init zsh)"

# Exported variables:
userpath="${HOME}/bin"
texpath=/opt/texlive/2021/bin/x86_64-linux
export GOPATH="${HOME}/Documents/Code/Go/packages"
export PATH="${PATH}:${userpath}:${GOPATH}/bin:${texpath}"

export GPG_TTY=${TTY}
export EDITOR='nvim'
export VISUAL=${EDITOR}
export BROWSER=$(which firefox-wayland)
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


# *****************************************************************************
# Aliases:

if [ -f "${HOME}/.sh_aliases" ]; then
	source "${HOME}/.sh_aliases"
fi


# *****************************************************************************
# Functions:

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

	if [[ -n "${pdfSelection}" ]]; then
		zathura --fork "${pdfSelection}" &
	fi
}

# cd to a searched directory.
leap() {
	local dirSelection;
	dirSelection="$(find ./ -type d ! -iwholename "*.git/*" | fzf \
			--query="$1")"

	if [[ -n "${dirSelection}" ]]; then
		cd "${dirSelection}" || return
	fi
}

# Edit a dotfile.
dot() {
	local dotSelection;
	dotSelection="$(find "${HOME}/.Dotfiles" -type f ! -iwholename "*.git/*" \
			! -iwholename "*/plugged/*" -printf "%P\n" \
			| fzf --preview="${FZF_DEFAULT_PREVIEW} ${HOME}/.Dotfiles/{}"\
			--query="$1")"

	if [[ -n ${dotSelection} ]]; then
		${EDITOR} "${HOME}/.Dotfiles/${dotSelection}"
	fi
}

# Make a manual timestamped btrfs readonly snapshot.
btrsnap() {
	local tsFormat="+%Y%m%d_%H%M%S%z"

	sudo btrfs subvolume snapshot -r / /snapshots/root/snapshot-root_"$(date ${tsFormat})"
	sudo btrfs subvolume snapshot -r /home /snapshots/home/snapshot-home_"$(date ${tsFormat})"
}

# Kill a program through fuzzy finder.
fk() {
	killSelection=$(ps -u "$(whoami)" -o pid,tty,comm | tail +2 | fzf | awk '{print $1}')

	if [ -n "${killSelection}" ]; then
		kill "${killSelection}"
	fi
}

# Purge old Void Linux kernels.
vkp() {
	sudo vkpurge rm "$(vkpurge list | fzf)"
}

# Install Void Linux packages.
xbi() {
	local pkgSelection=$(xbps-query -Rs "*" | fzf -m --tiebreak=begin \
		--query="$1" | awk '{ print $2 }')

	if [ -n "${pkgSelection}" ]; then
		sudo xbps-install -Svu "$(echo "${pkgSelection}" | tr '\n' ' ')"
	fi
}

# Remove manually installed Void Linux packages.
xbr() {
	local pkgSelection=$(xbps-query -m | fzf -m --preview-window follow \
		--preview="xbps-query {}")

	if [ -n "${pkgSelection}" ]; then
		sudo xbps-remove -R "$(echo "${pkgSelection}" | tr '\n' ' ')"
	fi
}


# *****************************************************************************
# Launch Programs:

# Window Manager:
if [[ "${TTY}" == "/dev/tty1" ]]; then
	echo "Launching Sway..."
	sleep 2
	exec dbus-run-session sway --unsupported-gpu
fi
