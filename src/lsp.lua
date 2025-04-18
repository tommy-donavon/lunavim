vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable {
  'astro',
  'elixirls',
  'golangci_lint_ls',
  'graphql',
  'hls',
  'lua_ls',
  'nil_ls',
  'phpactor',
  'svelte',
  'terraformls',
  'tflint',
  'ts_ls',
  'zls',
}
