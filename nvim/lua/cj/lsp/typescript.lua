local lspconfig = require("lspconfig")
local u = require("cj.utils")

local M = {}

M.setup = function(on_attach, capabilities)
  lspconfig.tsserver.setup({
    server = {
      on_attach = function(client, bufnr)
        u.buf_map(bufnr, "n", "gs", ":TypescriptRemoveUnused<CR>")
        u.buf_map(bufnr, "n", "gS", ":TypescriptOrganizeImports<CR>")
        u.buf_map(bufnr, "n", "go", ":TypescriptAddMissingImports<CR>")
        u.buf_map(bufnr, "n", "gA", ":TypescriptFixAll<CR>")
        u.buf_map(bufnr, "n", "gI", ":TypescriptRenameFile<CR>")

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    },
  })
end

return M
