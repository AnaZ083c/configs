# [ I ] Distro Setup Scripts
Can be found in `./scripts/distro_setups` and consists of scripts that set up your distro automatically. The setups are mostly made for computers with Nvidia cards, which are a bit of a hassle to get working on Linux, depending on the distro.

For any script in the `scripts/distro_setups` folder, you can get help for any of the scripts like shown below (example for `Endeavour OS`):
```bash
# EndeavourOS is the closest to vanilla Arch and is also based on Arch,
# so it's located in the arch-linux subdirectory
cd scripts/distro_setups/arch_linux

# run the help for the endeavour-os-nvidia script
bash endeavour-os-nvidia.sh --help
```

```bash
# output
This is a script for automatic setting up of EndeavourOS with all the necesary Nvidia drivers and essentials for gaming

Usage:
        ./endeavour-os-nvidia.sh [--optimus | -o | --help | -h]

        --optimus, -o   Using this, the system will be setup with prime and envycontrol for switching between the GPUs
        --help, -h      This help
```

# [ II ] Linux (Ubuntu) Development Environment
This repo also includes configs used to create a development enviroment (for Ubuntu) that is as efficient to a developer as possible; independent of the mouse as much as possible.

## Table of Contents
1. [Neovim setup](#1-neovim)
    - [How-To-Use guide for this specific config](./.config/nvim/README.md)
3. [Tmux and Tmuxifier setup](#2-tmux)
4. [i3 Window Manager](#3-i3-window-manager)
    - [Configuring low battery level notification](./.config/i3/README.md)
5. [Sources](#sources)


# Setup
## 1. NeoVim
**Install NeoVim**
```shell
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

To make `nvim` your default text editor, add this to your shell config (could be `.zshrc` or `.bashrc`)
```shell
export PATH="$PATH:/opt/nvim-linux64/bin"
export EDITOR='nvim'
```

**Install requirements**

First install requirements for the LSP plugin to work:
```shell
sudo apt install nodejs npm exuberant-ctags silversearcher-ag ripgrep fd-find
```

**Install the config**

Neovim config is located in `./.config/nvim`, to apply this config, simply:
```shell
cp -r ~/path/to/this/repo/.config/nvim ~/.config/nvim
```
You may or may not have to install dependencies for all the plugins to work. If something doesn't work as intended, please take a look at one of the nvim config videos listed among sources below.

A helpfull command within `nvim` is also `checkhealth`, to check if all plugins work correctly and if not, it provides helpfull information to fix the problems:
```shell
:checkhealth
```

It is recommended to watch at least the first video for NeoVim config, to get you started with the basics of configuring neovim using lua and Packer package manager.

- Packer official docs/repo: https://github.com/wbthomason/packer.nvim

To check if everything works:
```shell
nvim ~/.config/nvim/lua/core/plugins.lua

# Inside nvim:
:PackerSync
# This is to ensure all plugins are installed and up to date
```
**NOTE:** The first run might take a while because the plugins are auto-installing and you might get some error messages displayed, but that's okay.

Once everything is done installing (you should see a list of packages on the left side pane). When you get that, simply quit neovim, reopen it, and run `:PackerSync` to make sure all packages are installed and up to date.

**NOTE:** To get you started with using this specific NeoVim config, this [How-To-Use guide for this specific config](./.config/nvim/README.md) may come in handy.

## 2. Tmux
**Install tmux**
```shell
sudo apt update
sudo apt install tmux
```

Tmux config is located in `./.tmux.conf`.

**Install tmux plugin manager**
```shell
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
```

To use the config provided here:
```shell
cp ~/path/to/this/repo/.tmux.conf ~/.tmux.conf
```

To apply the config:
```shell
# Start tmux
tmux

# Within the tmux session
Ctrl+s+I  # To install all plugins
Ctrl+s+r  # Source tmux (refresh)
```

### Tmuxifier
Tmuxifier repo - https://github.com/jimeh/tmuxifier

**1. Install:**
```shell
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
```
For additional how-tos for tmuxifier, either visit the official repo for docs or follow the video tutorial listed among the sources below.

**2. Add configs to your shell (.zshrc, .bashrc - depending on the shell you're using):**
```shell
export EDITOR='nvim'
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
```

## 3. i3 Window Manager
That's to make your desktop environment not as dependant on mouse clicking as the default would be.

### Requirements
| package | what for |
| ------- | -------- |
| feh     | setting up a wallpaper   |
| redshift | setting up a color temperature |
| i3lock | locking the screen |
| brightnessctl | adjusting screen brightness |
| playerctl | audio player keyboard controlls (pause, resume, skip, go back) |
| rofi | window switcher, app launcher and dmenu replacement |
| blueman | for bluetooth support (requires bluez and bluez-obexd) |

**Note**: you'll also need to install a `CodeNewRoman Nerd Font Mono` to make all the icons work properly.

### 1. install i3
```shell
# For Ubuntu
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3
```

### 2. install requirements
```shell
sudo apt update
sudo apt install feh redshift i3lock brightnessctl playerctl rofi blueman bluez bluez-obexd
```

**Install font**
```shell
# If you don't have ~/.fonts/ directory yet
mkdir ~/.fonts/

# Install
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CodeNewRoman.zip -o ~/.fonts/CodeNewRoman.zip && unzip ~/.fonts/CodeNewRoman.zip

reboot
```

### 3. After reboot
1. Click on your user profile
2. On the boottom right corner, click on the cog wheel and select `i3`
3. Log in with your password
4. Go through `i3` wizard (make sure to select `yes` to generating a config)

**Note**: it might take some time to startup on the first time, because of `i3` setting up.

### 4. Using this repo's config
1. Clone this repo wherever you like
2. Copy `this-repo/.config/i3` and `this-repo/.config/i3status` into `~/.config/`
```shell
cp path-to-this-repo/.config/i3* ~/.config/ && \
cp path-to-this-repo/.config/rofi ~/.config/
```
3. Reload your config file: `$mod+Shift+c`
    - `$mod` is whatever key you chose in the setup wizard; it could be `Alt` or `Win`: this config is made with `Alt` as the `$mod`

## Sources
### NVIM config
1. Make nvim fancy, nvim plugin manager, nvim lua config structure (basics): https://youtu.be/J9yqSdvAKXY?list=PLsz00TDipIffxsNXSkskknolKShdbcALR
2. Autocomplete and other plugins: https://www.youtube.com/watch?v=h4g0m0Iwmys
3. LSP: https://www.youtube.com/watch?v=lpQMeFph1RE

### TMUX config
1. Make tmux great again: https://youtu.be/H70lULWJeig 
2. Tmux plugins: https://youtu.be/qyV_hOtMdwg
3. Tmuxifier: https://www.youtube.com/watch?v=ceRYL271cao

### Tmuxifier repo
- https://github.com/jimeh/tmuxifier

### i3 docs
1. Installation guide: https://i3wm.org/docs/repositories.html
2. User guide for config: https://i3wm.org/docs/userguide.html
3. Config docs for i3bar: https://i3wm.org/docs/userguide.html#_configuring_i3bar
4. Config docs for i3status: https://i3wm.org/docs/i3status.html

### Other useful links for customizing your setup
1. Color pallete: https://coolors.co/231f3b-18152e-4f497f-6157a9-eadaa2
