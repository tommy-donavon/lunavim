return {
  'markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  after = function()
    local wk = require('which-key')
    return wk.add {
      mode = { 'n', 'v' },
      {
        '<leader>tmp',
        ':MarkdownPreviewToggle<CR>',
        desc = '[t]oggle [m]arkdown preview',
      },
    }
  end,
}
