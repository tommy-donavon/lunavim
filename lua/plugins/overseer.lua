return {
  'overseer.nvim',
  after = function()
    local overseer = require('overseer')
    local wk = require('which-key')
    overseer.setup()
    wk.add {
      {
        mode = { 'n', 'v' },
        {
          '<leader>or',
          ':OverseerRun<CR>',
          desc = '[o]verseer [r]un',
        },
        {
          '<leader>ot',
          ':OverseerToggle<CR>',
          desc = '[o]verseer [t]oggle',
        },
      },
    }
  end,
}
