require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "c",
    "lua",
    "rasi",
    "rust",
    "requirements",
    "ruby",
    "rego",
    "vim",
    "html",
    "xml",
    "json",
    "yaml",
    "dockerfile",
    "make",
    "python",
    "css",
    "scss",
    "markdown",
    "markdown_inline",
    "go"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

vim.filetype.add({
  extension = {
    tfstate = "json",
    rasi = "rasi",
    vimwiki = "markdown",
  },
})

