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

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.keymap.set('n', '<Space>fk', builtin.keymaps, {})
vim.keymap.set('n', '<Space>fc', builtin.colorscheme, {})

