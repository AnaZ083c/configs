vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.number = true

-- enable whitespace display
vim.g.list = true
vim.g.listchars = "trail:·,tab:»·,extends:→,precedes:←,nbsp:␣"

-- use spaces for tabs, etc.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- font editing
vim.opt.linespace = 5

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

