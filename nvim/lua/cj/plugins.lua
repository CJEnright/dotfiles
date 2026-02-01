return {
  "nvim-lua/plenary.nvim",

  -- File explorer
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        columns = {},
        keymaps = {
          ["<C-o>"] = "actions.close",
        },
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>")
    end,
  },

  -- Completion (blink.cmp)
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      sources = { default = { "lsp", "path", "buffer" } },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        yaml = { "prettierd" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<Leader>f", "<cmd>Telescope find_files<cr>" },
      { "<Leader>r", "<cmd>Telescope live_grep<cr>" },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parsers = { "lua", "typescript", "javascript", "tsx", "json", "yaml", "html", "css", "bash", "rust", "prisma" }
      for _, parser in ipairs(parsers) do
        pcall(function() vim.treesitter.language.add(parser) end)
      end
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▐" },
        change = { text = "▐" },
        delete = { text = "▐" },
        topdelete = { text = "▐" },
        changedelete = { text = "▐" },
      },
    },
  },
}
