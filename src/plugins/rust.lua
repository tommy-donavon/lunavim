return {
  'rustaceanvim',
  lazy = false,
  after = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            files = {
              excludeDirs = {
                '.cargo',
                '.direnv',
                '.git',
                'target',
              },
            },
          },
        },
      },
    }
  end,
}
