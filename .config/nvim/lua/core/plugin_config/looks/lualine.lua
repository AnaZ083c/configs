local helper = require("core.plugin_config.utils.helper")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' } -- { left = '', right = '' }
 },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype', helper.fetch_python_version},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_b = {helper.fetch_python_version},
    lualine_c = {'filename'}
  }
}

