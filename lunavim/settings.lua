local utils = require('lunavim.utils')

utils.setopts(
  vim.opt,
  utils.mkdef {
    'autoindent',
    'breakindent',
    'expandtab',
    { 'mouse', 'a' },
  }
)

utils.setopts(
  vim.opt,
  utils.mkdef {
    'autoindent',
    'breakindent',
    'expandtab',
    'hlsearch',
    'ignorecase',
    'incsearch',
    'linebreak',
    'number',
    'relativenumber',
    'ruler',
    'showmatch',
    'showmode',
    'smartcase',
    'spell',
    'undofile',
    'visualbell',
    {
      'mouse',
      'a',
    },
    {
      'shiftwidth',
      default_indent,
    },
    {
      'showbreak',
      '+++',
    },
    {
      'softtabstop',
      default_indent,
    },
    {
      'spelllang',
      'en_us',
    },
    {
      'tabstop',
      default_indent,
    },
    {
      'timeoutlen',
      500,
    },
    {
      'undolevels',
      1000,
    },
    {
      'listchars',
      {
        tab = '» ',
        trail = '·',
        nbsp = '␣',
      },
    },
  }
)
