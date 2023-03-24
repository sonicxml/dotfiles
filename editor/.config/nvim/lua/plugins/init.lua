return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- use {
	--   "windwp/nvim-autopairs",
  --   config = function()
  --     require("nvim-autopairs").setup {}
  --   end,
  -- }


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-compe'
  use 'liuchengxu/vista.vim'
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind-nvim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Color Schemes
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  use 'rmehri01/onenord.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'projekt0n/github-nvim-theme'

  -- Files
  use {
    'kyazdani42/nvim-tree.lua',
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
        require("pconfs.nvimtree").setup()
    end,
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- UI
  use 'romgrk/barbar.nvim'
  use 'Famiu/feline.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- Helpful
  use "folke/which-key.nvim"
  use 'Pocco81/TrueZen.nvim'
  use 'ggandor/leap.nvim'
  use {
    "akinsho/toggleterm.nvim",
    tag = 'v2.*',
    config = function()
      require("toggleterm").setup()
    end,
  }
end)

