local lfs = require('lfs')

local cache_path = vim.fn.stdpath(vim.fs.normalize('cache'))
if lfs.attributes(cache_path) ~= 'directory' then
  lfs.mkdir(cache_path)
end

require('lunavim.settings')
require('lunavim.keymaps')
require('lunavim.ft')
require('lz.n').load('lunavim.plugins')
require('lunavim.lsp')

require('nvim-autopairs').setup()
vim.notify = require('notify')

require('lunavim.health').loaded = true
