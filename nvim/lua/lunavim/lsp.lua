vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable {
  'astro',
  'elixirls',
  'golangci_lint_ls',
  'gopls',
  'graphql',
  'hls',
  'lua_ls',
  'nil_ls',
  'phpactor',
  'pyright',
  'svelte',
  'terraformls',
  'tflint',
  'ts_ls',
  'yamlls',
  'zls',
}
