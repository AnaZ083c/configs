require("dapui").setup()

local dapui = require("dapui")
local dap = require("dap")
local dap_ext_vscode = require("dap.ext.vscode")
local dap_python = require("dap-python")

local helper = require("core.plugin_config.debugger.helper")

-- Default debugpy setup
dap_python.setup("~/.virtualenvs/debugpy/bin/python")
require("nvim-dap-virtual-text").setup()

-- Look and feel
vim.fn.sign_define('DapBreakpoint', { text='🐞', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

-- Keymaps
vim.keymap.set('n', '<leader>dn', function() dap_python.test_method() end)
vim.keymap.set('n', '<leader>df', function() dap_python.test_class() end)
vim.keymap.set('n', '<leader>ds<ESC>', function() dap_python.debug_selection() end)

-- Debug UI
vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require("dapui").toggle()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dapui").open({reset = true})<CR>', {noremap=true})

local dap_loaded = false
vim.keymap.set("n", "<F5>",
  function()
    if vim.bo.filetype == "python" then
      dap_python.setup(helper.get_debugpy(helper.constants.DEBUGPY_VENV_DIR))
    end
    dap_ext_vscode.load_launchjs(nil, {})

    dap.continue()
    -- dap.terminate()
    -- dap.run()
  end
)
vim.keymap.set("n", "<F9>", function() dap.continue() end)
vim.keymap.set("n", "<F8>", function() dap.step_over() end)
vim.keymap.set("n", "<F7>", function() dap.step_into() end)
vim.keymap.set("n", "<S-F7>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>bc", function() dap.clear_breakpoints() end)


-- Auto open/close Dap UI
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
