#
# ███████╗ ██████╗██╗  ██╗
# ╚════██║██╔════╝██║  ██║
#   ███╔═╝╚█████╗ ███████║
# ██╔══╝   ╚═══██╗██╔══██║
# ███████╗██████╔╝██║  ██║
# ╚══════╝╚═════╝ ╚═╝  ╚═╝
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
	autojump
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source "${ZSH}/oh-my-zsh.sh"


# *****************************************************************************
# Variables and Options:

# Starship prompt
#eval "$(starship init zsh)"

# Exported variables:
binpath="${HOME}/.bin:${HOME}/.local/bin"
export GOPATH="${HOME}/Documents/Code/.go"
export PATH="${PATH}:${binpath}:${GOPATH}/bin"

export GPG_TTY=${TTY}
export EDITOR='nvim'
export VISUAL=${EDITOR}
export XDG_CONFIG_HOME="${HOME}/.config"
export FZF_DEFAULT_PREVIEW="bat --color=always --style=header,grid -r :300"

# OCaml opam configuration
[[ ! -r /home/siddhartha/.opam/opam-init/init.zsh ]] \
	|| source /home/siddhartha/.opam/opam-init/init.zsh  > /dev/null 2>&1

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
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


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
	local searchRoot="./"

	if [ -n "$1" ]; then
		searchRoot="$1"
	fi

	pdfSelection="$(find "${searchRoot}" -type f -iname "*.pdf" | fzf --multi \
			--preview='pdftotext -f 1 -l 3 {} -')"

	if [[ -n "${pdfSelection}" ]]; then
		sioyek "${pdfSelection}" & disown
	fi
}

# cd to a searched directory.
leap() {
	local dirSelection;
	local searchRoot="./"

	if [ -n "$1" ]; then
		searchRoot="$1"
	fi

	dirSelection="$(find "${searchRoot}" -type d ! -iwholename "*.git/*" | fzf)"

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

btrc() {
	local rootNum=$(ls -1d /snapshots/root/@root* | wc -l)
	local homeNum=$(ls -1d /snapshots/home/@home* | wc -l)

	echo "Root snapshots: ${rootNum}"
	echo "Home snapshots: ${homeNum}"
}

# Kill a program through fuzzy finder.
fk() {
	local killSelection=$(ps -u "$(whoami)" -o pid,tty,comm | tail +2 | fzf | awk '{print $1}')
	local signal=INT

	if [ -n "$1" ]; then
		signal = $1
	fi

	if [ -n "${killSelection}" ]; then
		kill -"${signal}" "${killSelection}"
	fi
}

# Purge old Void Linux kernels.
vkp() {
	local keepKernels=2

	for oldKernel in $(vkpurge list | head -n -${keepKernels}); do
		sudo vkpurge rm "${oldKernel}"
	done

	echo "Done."
}

# Install Void Linux packages.
xbi() {
	local pkgSelection=$(xbps-query -Rs "*" | fzf --multi --tiebreak=begin \
		--query="$1" | awk '{ print $2 }')

	if [ -n "${pkgSelection}" ]; then
		# $(echo ${singlestring}) splits the string.
		sudo xbps-install -Svu $(echo ${pkgSelection})
	fi
}

# Remove manually installed Void Linux packages.
xbr() {
	local pkgSelection=$(xbps-query -m | fzf --multi --tiebreak=begin \
		--preview-window follow --preview="xbps-query {}")

	if [ -n "${pkgSelection}" ]; then
		# $(echo ${singlestring}) splits the string.
		sudo xbps-remove -R $(echo ${pkgSelection})
	fi
}

# Get info about installed Void Linux packages.
xbq() {
	local pkgSelection=$(xbps-query -Rs "*" | fzf --multi --tiebreak=begin \
		--query="$1" | awk '{ print $2 }')

	if [ -n "${pkgSelection}" ]; then
		# $(echo ${singlestring}) splits the string.
		xbps-query -R $(echo ${pkgSelection}) | less
	fi
}

# Copy files to wayland clipboard.
wlc() {
	cat "$@" | wl-copy -n
}

# Toggle WireGuard runit service.
wgt() {
	case "$(sudo sv status wireguard | cut -d ':' -f 1)" in
		"down")
			sudo sv start wireguard
			;;
		"run")
			sudo sv stop wireguard
			;;
	esac
}
