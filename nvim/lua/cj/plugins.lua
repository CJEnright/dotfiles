return {
  "nvim-lua/plenary.nvim",

  -- File explorer
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open file explorer" },
    },
    opts = {
      view_options = { show_hidden = true },
      columns = {},
      keymaps = {
        ["q"] = "actions.close",
      },
    },
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
  { "neovim/nvim-lspconfig", event = "BufReadPre" },
  { "williamboman/mason.nvim", event = "BufReadPre" },
  { "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },

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
    cmd = "Telescope",
    keys = {
      { "<Leader>f", "<cmd>Telescope find_files<cr>" },
      { "<Leader>r", "<cmd>Telescope live_grep<cr>" },
    },
  },

  -- Treesitter (parsers managed via :TSInstall, highlighting is native in 0.11+)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
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
