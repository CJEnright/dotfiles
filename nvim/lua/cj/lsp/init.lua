require("mason").setup()

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local buf_command = function(bufnr, name, fn, opts)
  vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

local on_attach = function(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  buf_map(bufnr, "n", "<C-]>", ":LspDef<CR>")
  buf_map(bufnr, "n", "gr", ":LspRename<CR>")
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  buf_map(bufnr, "n", "K", ":LspHover<CR>")
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
  buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")

  if client.supports_method("textDocument/formatting") then
    buf_command(bufnr, "LspFormatting", function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          -- Use eslint instead of tsserver
          if client.name == "tsserver" then
            return false
          end

          return true
        end
      })
    end)

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      command = "LspFormatting",
    })
  end
end
-- Servers that don't need any additional config
local default_servers = { "prismals", "jsonls", "yamlls", "cssls", "tailwindcss", "dockerls", "bashls", "rust_analyzer"  }
-- Servers with custom options
local custom_servers = { "tsserver",  "eslint", "null-ls", }

local all_servers = {}
table.foreach(default_servers, function(k, v) table.insert(all_servers, v) end)
table.foreach(custom_servers, function(k, v) table.insert(all_servers, v) end)

require("mason-lspconfig").setup({
	ensure_installed = all_servers,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs(default_servers) do
  require("lspconfig")[server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

for _, server in pairs(custom_servers) do
  require("cj.lsp." .. server).setup(on_attach, capabilities)
end

