# Description
This repo consists of **neovim**, **tmux** and other configs.

# Setup
## 1. Neovim
Assuming you have neovim installed.

Neovim config is located in `./.config/nvim`, to apply this config, simply:
```shell
cp ~/path/to/this/repo/.config/nvim ~/.config/nvim
```
You may or may not have to install dependencies for all the plugins to work. If something doesn't work as intended, please take a look at one of the nvim config videos listed among sources below.

It is recommended to watch at least the first video for neovim config, to get you started with the basics of configuring neovim using lua and Packer pacgage manager.

To check if everything works:
```shell
nvim ~/.config/nvim/lua/core/plugins.lua

# Inside nvim:
:PackerSync
# This is to ensure all plugins are installed and up to date
```

## 2. Tmux
Assuming you have tmux installed.

Tmux config is located in `./.tmux.conf`, it's plugins in `./.tmux/`.

To apply the config:
```shell
# Start tmux
tmux

# Within the tmux session
Ctrl + s + I  # To ensure all plugins are installed
Ctrl + s + r  # Source tmux (refresh)
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
