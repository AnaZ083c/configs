local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local dap_python = require('dap-python')

local helper = require("core.plugin_config.debugger.helper")


local python_debuggers_path = helper.constants.DEBUGPY_VENV_DIR


local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local debugger = vim.inspect(selected.value[2])

  dap_python.setup(debugger)
  vim.schedule(function() vim.api.nvim_out_write("Debugger set to: " .. selected.value[1] .. "\n") end)

  actions.close(prompt_bufnr)
end


local appearance = {
  layout_strategy = "vertical",
  layout_config = {
    height = 10,
    width = 0.3,
    prompt_position = "top"
  },
  sorting_strategy = "ascending"
}


local opts = {
  prompt_title = "Python debuggers",
  finder = finders.new_table {
    results = helper.get_python_venvs(python_debuggers_path, "󰌠"),
    entry_maker = function(entry)
      return {
        value = entry,
        display = entry[1],
        ordinal = entry[1],
      }
    end
  },
  sorter = sorters.get_generic_fuzzy_sorter({}),
  attach_mappings = function (prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("n", "<CR>", enter)
    return true
  end,
}


local pick = pickers.new(appearance, opts)
vim.keymap.set("n", "<leader>fp", function() pick:find() end)

