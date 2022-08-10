local null_ls = require("null-ls")

local M = {}

M.setup = function(on_attach)
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettierd.with({
        disabled_filetypes = { "markdown" }
      })
    },
    on_attach = on_attach,
  })
end

return M
