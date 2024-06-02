local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- The Packer package manager
  use 'neovim/nvim-lspconfig'  -- Configuration for NVIM Language Server Protocol (LSP)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- file icons
    },
    tag = 'nightly' -- updated every week
  }
  use {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make' 
  }
  use "terrortylor/nvim-comment"
  use 'folke/tokyonight.nvim'

  -- Window tabs
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use '/Users/Devin/Desktop/Github/DevinLeamy/jot.nvim'
  -- use 'https://github.com/DevinLeamy/jot.nvim.git'

  use '/Users/Devin/Desktop/Programming/Lua/dl.nvim'
end)
