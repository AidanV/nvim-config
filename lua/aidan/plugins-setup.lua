local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Lua functions that many plugins use
  use { "nvim-lua/plenary.nvim" }

  -- Theme
  -- use { "ellisonleao/gruvbox.nvim" }
  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- Tmux commands for navigating windows
  use { "christoomey/vim-tmux-navigator" }

  -- Maximize a window
  use { "szw/vim-maximizer" }

  -- Automatic Commenting
  use { "numToStr/Comment.nvim" }

  -- File explorer
  use { "nvim-tree/nvim-tree.lua" }

  -- File Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status line
  use { "nvim-lualine/lualine.nvim" }

  -- Fuzzy finding
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } -- dependency
  use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }

  -- Autocompete
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }

  -- Snippets
  use {  "L3MON4D3/LuaSnip" }
  use {  "saadparwaiz1/cmp_luasnip" }
  use {  "rafamadriz/friendly-snippets" }

  -- LSP Management
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

  -- LSP Configuration
  use { "neovim/nvim-lspconfig" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use { "onsails/lspkind.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
