-- Ensure packer is available, if not download it
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  require("cj.packer")()
  packer = require("packer")
end

local packer_options = {
  auto_clean = true,
  compile_on_sync = true,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.init(packer_options)

-- Reload neovim when plugins.lua saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return packer.startup(function(use)
  use "lewis6991/impatient.nvim"
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-tree.lua"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-copilot"
	use "dcampos/nvim-snippy"
	use "dcampos/cmp-snippy"
  use "github/copilot.vim"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "jose-elias-alvarez/null-ls.nvim"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "pantharshit00/vim-prisma"

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '▐', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '▐', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '▐', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
      }
    end
  }


  -- If we just downloaded packer, install plugins
  if not status_ok then
    vim.cmd "PackerSync"
  end
end)
