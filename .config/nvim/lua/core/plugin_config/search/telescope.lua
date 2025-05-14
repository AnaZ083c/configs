require('telescope').setup({
  file_ignore_patterns = { "node%_modules/.*", ".venv/." },
  defaults = {
    layout_config = {
      bottom_pane = {
        height = 25,
        preview_cutoff = 120,
        prompt_position = "top"
      },
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = "top",
        width = 0.5
      },
      cursor = {
        height = 0.6,
        preview_cutoff = 40,
        width = 0.5
      },
      horizontal = {
        height = 0.6,
        preview_cutoff = 120,
        prompt_position = "top",
        width = 0.5
      },
      vertical = {
        height = 0.6,
        preview_cutoff = 40,
        prompt_position = "bottom",
        width = 0.5
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
})
local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fn', extensions.notify.notify, {})

