vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general editor config
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true

-- enable whitespace display
vim.opt.list = true
vim.opt.listchars:append({
  tab = "| ",
  trail = "·",
  eol = "↩"
})

-- use spaces for tabs, etc.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- font editing
vim.opt.linespace = 5

-- reset search
vim.keymap.set('n', '<leader>nh', ':nohlsearch<CR>')

-- show newlines
-- vim.api.nvim_set_keymap('n', '<leader>vl', ':set list listchars=tab:>\\ ,trail:-,eol:↵<CR>', { noremap=true, silent=true })

-- window resize
vim.api.nvim_set_keymap('n', '<leader>l', ':vertical resize +10<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>h', ':vertical resize -10<CR>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', '<leader>j', ':resize +10<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>k', ':resize -10<CR>', { noremap=true, silent=true })
