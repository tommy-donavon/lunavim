return {
  {
    'simrat39/inlay-hints.nvim',
    after = function()
      require('inlay-hints.nvim').setup {}
    end,
  },
  {
    'rcarriga/nvim-notify',
    lazy = false,
    after = function()
      vim.notify = require('notify')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = true,
    opts = {},
  },
}
