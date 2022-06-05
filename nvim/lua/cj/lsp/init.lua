local u = require("cj.utils")

local on_attach = function(client, bufnr)
  -- commands
  u.buf_command(bufnr, "LspHover", vim.lsp.buf.hover)
  u.buf_command(bufnr, "LspDiagPrev", vim.diagnostic.goto_prev)
  u.buf_command(bufnr, "LspDiagNext", vim.diagnostic.goto_next)
  u.buf_command(bufnr, "LspDiagLine", vim.diagnostic.open_float)
  u.buf_command(bufnr, "LspDiagQuickfix", vim.diagnostic.setqflist)
  u.buf_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help)
  u.buf_command(bufnr, "LspTypeDef", vim.lsp.buf.type_definition)
  u.buf_command(bufnr, "LspRangeAct", vim.lsp.buf.range_code_action)
  -- not sure why this is necessary?
  u.buf_command(bufnr, "LspRename", function()
    vim.lsp.buf.rename()
  end)

  -- bindings
  u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
  u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
  u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

  u.buf_map(bufnr, "n", "gy", ":LspRef<CR>")
  u.buf_map(bufnr, "n", "gh", ":LspTypeDef<CR>")
  u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  u.buf_map(bufnr, "n", "ga", ":LspAct<CR>")
  u.buf_map(bufnr, "v", "ga", "<Esc><cmd> LspRangeAct<CR>")

  --if client.supports_method("textDocument/formatting") then
  --  u.buf_command(bufnr, "LspFormatting", function()
  --    lsp_formatting(bufnr)
  --  end)

  --  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --  vim.api.nvim_create_autocmd("BufWritePre", {
  --    group = augroup,
  --    buffer = bufnr,
  --    command = "LspFormatting",
  --  })
  --end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs({
  "typescript",
}) do
  require("cj.lsp." .. server).setup(on_attach, capabilities)
end

