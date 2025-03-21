local cfg = {
  options = {
    test = 'test',
    component_separators = '',
    theme = 'auto',
    section_separators = {
      left = '',
      right = '',
    },
    globalstatus = true,
    icons_enabled = true,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = {
          left = '',
        },
        right_padding = 2,
      },
    },
    lualine_b = {
      'filename',
      'branch',
      'diff',
      'diagnostics',
    },
    lualine_c = {
      '%=',
    },
    lualine_x = {
      'overseer',
    },
    lualine_y = {
      'filetype',
      'progress',
    },
    lualine_z = {
      {
        'location',
        separator = {
          right = '',
        },
        left_padding = 2,
      },
    },
  },
}

return {
  'lualine.nvim',
  after = function()
    local lualine = require('lualine')
    vim.opt.showmode = false
    vim.o.laststatus = 3
    lualine.setup(cfg)
  end,
}
