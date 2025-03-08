return {
  'which-key.nvim',
  event = 'VimEnter',
  after = function()
    local wk = require('which-key')
    return wk.setup {
      icons = {
        mappings = true,
      },
      spec = {
        {
          '<leader>c',
          group = '[c]ode',
          mode = { 'n', 'x' },
        },
        {
          '<leader>d',
          group = '[d]ocument',
        },
        {
          '<leader>r',
          group = '[r]ename',
        },
        {
          '<leader>s',
          group = '[s]earch',
        },
        {
          '<leader>w',
          group = '[w]orkspace',
        },
        {
          '<leader>t',
          group = '[t]oggle',
        },
        {
          '<leader>g',
          group = '[g]it',
          mode = { 'n', 'v' },
        },
        {
          '<leader>f',
          group = '[f]ormat',
          mode = { 'n', 'v' },
        },
        {
          '<leader>o',
          group = '[o]verseer',
          mode = { 'n', 'v' },
        },
      },
    }
  end,
}
