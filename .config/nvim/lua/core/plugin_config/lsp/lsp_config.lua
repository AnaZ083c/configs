require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ansiblels",
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "docker_compose_language_service",
    "gopls",
    "html",
    "jsonls",
    "autotools_ls",
    "marksman",
    "jedi_language_server",
    "vimls"
  }
})


local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  }
}
require("lspconfig").ansiblels.setup {
  capabilities = capabilities,
}
require("lspconfig").bashls.setup {
  capabilities = capabilities,
}
require("lspconfig").clangd.setup { capabilities = capabilities,}
require("lspconfig").cssls.setup {  capabilities = capabilities,}
require("lspconfig").dockerls.setup {  capabilities = capabilities,}
require("lspconfig").docker_compose_language_service.setup {  capabilities = capabilities,}
require("lspconfig").gopls.setup {  capabilities = capabilities,}
require("lspconfig").html.setup {  capabilities = capabilities,}
require("lspconfig").jsonls.setup {  capabilities = capabilities,}
require("lspconfig").autotools_ls.setup {  capabilities = capabilities,}
require("lspconfig").marksman.setup {  capabilities = capabilities,}
require("lspconfig").jedi_language_server.setup {  capabilities = capabilities,}
require("lspconfig").vimls.setup {  capabilities = capabilities,}

