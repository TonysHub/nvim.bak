local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- This section will rarely change handle import from plugins.load
require('lazy').setup({
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      "astral-sh/ruff-lsp",
      { 'stevearc/conform.nvim', opts = {} },
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'kanagawa',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  { "nvim-treesitter/nvim-treesitter-context" },

  -- nice to have
  { 'folke/which-key.nvim' },
  { "folke/zen-mode.nvim" },
  { 'lukas-reineke/indent-blankline.nvim',    main = 'ibl' },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },
  { 'tpope/vim-sleuth' },
  { "windwp/nvim-autopairs", opts = {} },

  -- copilot
  { 'github/copilot.vim' },

  -- navigation
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- 'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } }
  },

  -- git
  { "airblade/vim-gitgutter" },
  { "kdheepak/lazygit.nvim" },
  { "tpope/vim-fugitive" },
  { 'tpope/vim-rhubarb' },

  -- text editing
  { "mg979/vim-visual-multi" },
  { "paradoxxxzero/pyls-isort" },
  { "python-lsp/python-lsp-black" },

  -- misc
  { "echasnovski/mini.bufremove", version = "*" },
  { "kevinhwang91/nvim-bqf",      ft = "qf" },
  { "mbbill/undotree" },
  { "nvim-pack/nvim-spectre",     opts = {} },
  { "tpope/vim-surround" },
  { "uga-rosa/ccc.nvim",          opts = {} },

  -- looks
  {
    "folke/noice.nvim",
    dependencies = { { "MunifTanjim/nui.nvim" }, { "rcarriga/nvim-notify" }, { "nvim-lua/plenary.nvim" } },
  },
  { "laytan/cloak.nvim",              opts = {} },
  { "nvim-lualine/lualine.nvim" },
  { "rebelot/kanagawa.nvim" },
  { 'norcalli/nvim-colorizer.lua' },
  { 'nathanaelkane/vim-indent-guides' },

  -- plugins with import settings
  { import = 'plugins.load' },
  { import = 'plugins.debug',         lazy = true }
}, {})

-- Setup neovim lua configuration
require('neodev').setup()

require("plugins.config").setup()
