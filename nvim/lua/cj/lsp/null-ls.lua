local null_ls = require("null-ls")

local M = {}

M.setup = function(on_attach)
  if not vim.g.started_by_firenvim then
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier.with({
          disabled_filetypes = { "markdown" }
        })
      },
      on_attach = on_attach,
    })
  end
end

return M
