return {
  'outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    {
      '<leader>to',
      ':Outline<CR>',
      desc = '[t]oggle [o]utline',
    },
  },
  after = function()
    require('outline').setup {
      symbol_folding = {
        autofold_deptch = false,
      },
      outline_window = {
        width = 30,
      },
    }
  end,
}
