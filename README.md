# Dotfiles

These are my personal dotfiles for Sway, Neovim, Zsh, and more. Deployment is done with GNU Stow.

# Install

Clone this repository into your home directory.
```
git clone https://github.com/Sqvid/Dotfiles.git ${HOME}/.Dotfiles
```
Change into the dotfile directory.
```sh
cd ${HOME}/.Dotfiles
```

Activate configs.
```sh
# Activate individual config (e.g. Neovim):
stow -v neovim
# Activate all configs:
./stowall -s
```

Depending on your use-case you may also want to download external packages such as
[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) and [vim-plug](https://github.com/junegunn/vim-plug)
that some of these configs call.

## Uninstall

Change into the dotfile directory.
```sh
cd ${HOME}/.Dotfiles
```

Deactivate configs.
```sh
# Deactivate individual config (e.g. Neovim):
stow -vD neovim
# Deactivate all configs:
./stowall -d
# Optionally remove the repository completely:
rm ${HOME}/.Dotfiles
```
