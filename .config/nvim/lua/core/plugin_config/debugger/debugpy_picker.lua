local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local dap_python = require('dap-python')

-- local helper = require('lua.core.plugin_config.debugger.helper')


local python_debuggers_path = "~/.virtualenvs/"


local function get_python_venvs(directory)
    local debuggers = {}

    local directories = io.popen("find " ..directory.. " -maxdepth 1 -type d | sed 1d")
    if directories == nil then
      print("No debuggers found.")
      return {}
    end

    local i = 1
    for debugger in directories:lines() do
      -- get python version 
      local version = io.popen(debugger.. "/bin/python --version")
      if version == nil then
        print("Couldn't get versions.")
        return {}
      end
      local python_version = version:read("*a"):gsub("\n", "")
      version:close()

      -- get relative paths
      debuggers[#debuggers+1] = { "󰌠 ".. python_version, debugger .. "/bin/python" }

      i = i + 1
    end
    directories:close()

    return debuggers
end


local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local debugger = vim.inspect(selected.value[2])

  dap_python.setup(debugger)
  vim.schedule(function() vim.api.nvim_out_write("Debugger set to: ".. selected.value[1] .."\n") end)

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
    results = get_python_venvs(python_debuggers_path),
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

