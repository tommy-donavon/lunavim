local lfs = require('lfs')

local cache_path = vim.fn.stdpath(vim.fs.normalize('cache'))
if lfs.attributes(cache_path) ~= 'directory' then
  lfs.mkdir(cache_path)
end

require('lunavim.settings')
require('lunavim.keymaps')
require('lunavim.ft')
require('lunavim.lsp')
require('lunavim.health').loaded = true
