local M = {}

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

M.setup = function(on_attach, capabilities)
  require("typescript").setup({
    server = {
      on_attach = function(client, bufnr)
        buf_map(bufnr, "n", "go", ":TypescriptAddMissingImports<CR>")
        buf_map(bufnr, "n", "gO", ":TypescriptOrganizeImports<CR>")
        buf_map(bufnr, "n", "gI", ":TypescriptRenameFile<CR>")

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    },
  })
end

return M
