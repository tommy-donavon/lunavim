local utils = require('lunavim.utils')

local default_indent = 4

vim.loader.enable()
vim.g.mapleader = ' '

vim.diagnostic.config { virtual_text = false, virtual_lines = { current_line = true } }

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
    clear = true,
  }),
  callback = function()
    return vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line('\'"')
    if line >= 1 and line <= vim.fn.line('$') then
      return vim.cmd('normal! g`')
    end
  end,
})

vim.opt.clipboard:append('unnamedplus')

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
    { 'mouse', 'a' },
    { 'shiftwidth', default_indent },
    { 'showbreak', '+++' },
    { 'softtabstop', default_indent },
    { 'spelllang', 'en_us' },
    { 'tabstop', default_indent },
    { 'timeoutlen', 500 },
    { 'undolevels', 1000 },
    { 'listchars', {
      tab = '» ',
      trail = '·',
      nbsp = '␣',
    } },
  }
)

-- disable builtin plugins
utils.setopts(
  vim.g,
  utils.mkdef {
    { 'loaded_gzip', 1 },
    { 'loaded_tar', 1 },
    { 'loaded_tarPlugin', 1 },
    { 'loaded_zipPlugin', 1 },
    { 'loaded_2html_plugin', 1 },
    { 'loaded_netrw', 1 },
    { 'loaded_netrwPlugin', 1 },
    { 'loaded_matchit', 1 },
    { 'loaded_matchparen', 1 },
    { 'loaded_spec', 1 },
  }
)

utils.runcmds {
  'filetype indent on',
  'filetype plugin on',
  'syntax on',
}
