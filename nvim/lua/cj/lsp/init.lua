require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "eslint", "prismals", "jsonls", "yamlls", "cssls", "tailwindcss", "dockerls", "bashls", "rust_analyzer" },
})

vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  float = { border = "rounded" },
})

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("blink.cmp").get_lsp_capabilities()
)

local servers = { "ts_ls", "eslint", "prismals", "jsonls", "yamlls", "cssls", "dockerls", "bashls", "rust_analyzer" }

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

-- Tailwindcss with restricted filetypes (exclude markdown)
vim.lsp.config("tailwindcss", {
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
})

vim.lsp.enable(servers)
vim.lsp.enable("tailwindcss")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gr", vim.lsp.buf.rename)
    map("n", "gl", vim.lsp.buf.references)
    map("n", "gy", vim.lsp.buf.type_definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "ga", vim.lsp.buf.code_action)
    map("n", "[a", vim.diagnostic.goto_prev)
    map("n", "]a", vim.diagnostic.goto_next)
    map("n", "<Leader>a", vim.diagnostic.open_float)
  end,
})
