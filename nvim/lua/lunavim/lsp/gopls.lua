local ih = require('inlay-hints')

---@type vim.lsp.Config
return {
  cmd = {
    'gopls',
  },
  filetypes = {
    'go',
    'gomod',
  },
  on_attach = function(c, b)
    return ih.on_attach(c, b)
  end,
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        rangeVariableTypes = true,
      },
    },
  },
}
