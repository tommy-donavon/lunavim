return {
  {
    'inlay-hints.nvim',
    event = { 'VimEnter' },
    after = function()
      require('inlay-hints').setup {}
    end,
  },
  {
    'nvim-notify',
    lazy = false,
    after = function()
      vim.notify = require('notify')
    end,
  },
  {
    'nvim-autopairs',
    event = { 'InsertEnter' },
    config = true,
    opts = {},
  },
  {
    'nvim-lspconfig',
    event = { 'VimEnter' },
  },
}
