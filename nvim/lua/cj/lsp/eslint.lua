local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, capabilities)
  lspconfig["eslint"].setup({
    root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      format = {
        enable = true,
      },
    },
    handlers = {
      -- this error shows up occasionally when formatting
      -- formatting actually works, so this will supress it
      ["window/showMessageRequest"] = function(_, result)
        if result.message:find("ENOENT") then
          return vim.NIL
        end

        return vim.lsp.handlers["window/showMessageRequest"](nil, result)
      end,
    },
  })
end

return M
