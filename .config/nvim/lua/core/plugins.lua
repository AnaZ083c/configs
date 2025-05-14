local ensure_packer = function()
  local fn = vim.fn local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Plugins go here --
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use { "ellisonleao/gruvbox.nvim" }
  use 'tiagovla/tokyodark.nvim'
  use 'rakr/vim-one'
  use 'stankovictab/mgz.nvim'
  use 'rafalbromirski/vim-aurora'
  use 'yonlu/omni.vim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- misc 
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  -- use {'tzachar/cmp-ai', requires = {'nvim-lua/plenary.nvim'}}  -- AI completion (ollama)
  -- use {'hrsh7th/nvim-cmp', requires = {'tzachar/cmp-ai'}}
  use {'hrsh7th/nvim-cmp'}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {
	  "windwp/nvim-autopairs",
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  use 'folke/lsp-colors.nvim'
  use {
    "folke/trouble.nvim",
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  -- Fancy UI
  use "folke/snacks.nvim"
  use "rcarriga/nvim-notify"
  use {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        file_types = { 'markdown', 'vimwiki' },
        render_modes = true, -- render in all modes
        sign = {
          enabled = false, -- turn off in status column
        },
      })
    end
  }

  use "tpope/vim-fugitive"
  use "lewis6991/gitsigns.nvim"
  use "terrortylor/nvim-comment"

  -- Markdown renderer
  use {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('render-markdown').setup({})
    end
  }

  -- DAP - debuggers
  use "mfussenegger/nvim-dap"
  use 'mfussenegger/nvim-dap-python'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
  use 'theHamsta/nvim-dap-virtual-text'

  -- AI - a local copilot
  use { "David-Kunz/gen.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
