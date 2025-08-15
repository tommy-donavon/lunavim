vim.lsp.config('*', {
	root_markers = { '.git' },
})

vim.lsp.config('biome', {
	root_markers = { 'biome.json' },
})

vim.lsp.config('jsonnet_ls', {
	cmd = { 'jsonnet-language-server', '--tanka' },
})

vim.lsp.enable {
	'astro',
	'elixirls',
	'golangci_lint_ls',
	'gopls',
	'graphql',
	'biome',
	'hls',
	'jsonnet_ls',
	'lua_ls',
	'nil_ls',
	'phpactor',
	'pyright',
	'qmlls',
	'solargraph',
	'svelte',
	'terraformls',
	'tflint',
	'ts_ls',
	'yamlls',
	'zls',
}
