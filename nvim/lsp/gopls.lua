---@type vim.lsp.Config
return {
  cmd = {
    'gopls',
  },
  filetypes = {
    'go',
    'gomod',
  },
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
