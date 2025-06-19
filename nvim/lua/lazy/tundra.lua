return {
  'nvim-tundra',
  lazy = false,
  priority = 1000,
  after = function()
    require('nvim-tundra').setup {
      transparent_background = false,
      dim_inactive_windows = {
        enabled = false,
      },
      sidebars = {
        enabled = true,
      },
      syntax = {
        booleans = { bold = true, italic = true },
        comments = { bold = true, italic = true },
        constants = { bold = true },
        operators = { bold = true },
        types = { italic = true },
      },
      plugins = {
        lsp = true,
        semantic_tokens = true,
        treesitter = true,
        telescope = true,
        nvimtree = true,
        cmp = true,
        context = true,
        dbui = true,
        snacks = true,
        gitsigns = true,
        neogit = true,
        textfsm = true,
      },
    }
    vim.g.tundra_biome = 'alpine'
    vim.opt.background = 'dark'
    vim.cmd('colorscheme tundra')
  end,
}
