return {
  'everforest-nvim',
  lazy = false,
  priority = 1000,
  after = function()
    local everforest = require('everforest')
    everforest.setup { background = 'medium' }
    everforest.load()
  end,
}
