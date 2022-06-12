local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig")["tsserver"].setup({
    server = {
      on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)

        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

        -- Disable formatting (handled by null-ls)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    },
  })
end

return M
