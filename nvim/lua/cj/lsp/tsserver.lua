local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, capabilities)
  lspconfig.tsserver.setup({
    server = {
      on_attach = function(client, bufnr)
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    },
  })
end

return M
