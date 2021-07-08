# Dotfiles

I dont like cluttering in `~` so I configured everything to respect xdg user
dirs.

## Software I use

* `zsh`, the z-shell
* `st` as a terminal emulator (therefore no terminal configs)
* `vim` for text editing with
  [jellybeans](https://github.com/nanotech/jellybeans.vim) colorscheme
* `dunst` for notifications
* `dwm` for tiling window managing
* `zathura` for document viewing

## Installation

1. clone my (or anyone elses, or the original and configure it your own) dwm
   and dwmblocks configs and `sudo make clean install`.
2. Copy `etc/systemd/system/autolock@.service` to `/etc/systemd/system/`-folder and
   enable it with `systemctl enable autolock@<your username>.service`.
3. Copy everything else to your home folder.

```bash
cp etc/systemd/system/autolock@.service /etc/systemd/system/
systemctl enable autolock@$(whoami).service
cp -r .zprofile .xinitrc ~
[ -d ~/.local/bin ] && cp -r .local/bin/* ~/.local/bin || cp -r .local ~
[ -d ~/.config ] && cp -r config/* ~/.config || cp -r .config ~
```
