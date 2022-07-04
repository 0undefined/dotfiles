# Dotfiles

I dont like cluttering in `~` so I configured everything to respect xdg user
dirs, and put all config files in `~/.config`.

## Software I use

* `zsh`, the z-shell
* `st`: terminal emulator (therefore no terminal configs)
* `vim`: for text editing with
  [moonfly](https://github.com/bluz71/vim-moonfly-colors) colorscheme
* `dunst`: notifications
* `dwm`: for tiling window managing
* `zathura`: for document viewing
* `screen`: GNU Screen for terminal multiplexing

## Installation

1. clone my (or anyone elses, or the original and configure it your own) dwm
   and dwmblocks configs and `sudo make clean install`.
   If you do not want to use dwm, you can change the `exec dwm` line in
   [xinitrc](.config/x/xinitrc)
2. Copy `etc/systemd/system/autolock@.service` to `/etc/systemd/system/`-folder and
   enable it with `systemctl enable autolock@<your username>.service`, in order
   to enable autolocking when putting your computer to sleep or hibernation.
3. `$ cp .local .config ~`

```bash
cp etc/systemd/system/autolock@.service /etc/systemd/system/
systemctl enable autolock@$(whoami).service
cp -r .zprofile .xinitrc ~
[ -d ~/.local/bin ] && cp -r .local/bin/* ~/.local/bin || cp -r .local ~
[ -d ~/.config ] && cp -r config/* ~/.config || cp -r .config ~
```

## Scripts

* cam_capture: captures a photo from a webcam, if any.
* color256: shows all 256 colors of the terminal, if supported.
* commits_by_hour: Shows how many commits a given repo has, sorted into which
  hour of the day they were committed.
* dmenu_run_history: Dmenu that presents most used commands from a history file.
* edit_document: opens a prompt listing all `.tex` files in your `~/documents`
  folder. Opens the document in your `$EDITOR` of choice. Fallbacks to `vim` by
  default.
* emoji: LukeSmiths `dmenu_unicode` script.
* [latexrun](https://github.com/aclements/latexrun): pdflatex python wrapper
  that automates references and puts all auxiliary files in a folder, nice and
  tidy.
* open_book: as `edit_document`, opens a prompt with all `.pdf` files in your
  `~/books` folder. Opens the chosen document in `$READER`, falls back to
  `zathura` if `$READER` is not set.
* plot_commits: Plots commits by hour (depends on `commits_by_hour`, python3 and
  matplotlib)
* select-sink: Dmenu prompt to select audio sink as default output.
* vimura: wrapper script to use synctex for a given pdf and vim instance.
* weather: presents `dmi.dk` weather for copenhagen.
