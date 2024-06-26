#
# ███████╗ ██████╗██╗  ██╗
# ╚════██║██╔════╝██║  ██║
#   ███╔═╝╚█████╗ ███████║
# ██╔══╝   ╚═══██╗██╔══██║
# ███████╗██████╔╝██║  ██║
# ╚══════╝╚═════╝ ╚═╝  ╚═╝
#

# *****************************************************************************
# Zsh Options:
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=5000
KEYTIMEOUT=10

setopt extendedglob
setopt correct
setopt nobeep
setopt menu_complete

# Completions:
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

autoload -Uz compinit; compinit
zmodload zsh/complist

# Bindkeys:
bindkey -v
bindkey "^?" backward-delete-char
bindkey "M-l" forward-char
bindkey "M-w" forward-word
bindkey '^R' history-incremental-search-backward
# Use vi keys in completion menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '0' vi-beginning-of-line
bindkey -M menuselect '$' vi-end-of-line
bindkey -M menuselect 'g' beginning-of-history
bindkey -M menuselect 'G' end-of-history

# Plugins:
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/autojump/autojump.zsh
# Add completions provided by zsh-completions plugin
fpath=(/usr/share/zsh/site-functions/ $fpath)

# *****************************************************************************
# Variables and Options:

# Exported variables:
binpath="${HOME}/.bin:${HOME}/.local/bin"
export GOPATH="${HOME}/Documents/Code/.go"
export PATH="${PATH}:${binpath}:${GOPATH}/bin"

export GPG_TTY=${TTY}
export EDITOR='nvim'
export VISUAL=${EDITOR}
export XDG_CONFIG_HOME="${HOME}/.config"
export FZF_DEFAULT_PREVIEW="bat --color=always --style=header,grid -r :300"

# Starship prompt
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
eval "$(starship init zsh)"

# OCaml opam configuration
[[ ! -r /home/siddhartha/.opam/opam-init/init.zsh ]] \
	|| source /home/siddhartha/.opam/opam-init/init.zsh  > /dev/null 2>&1


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
