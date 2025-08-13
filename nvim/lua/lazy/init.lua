return {
	{
		'nvim-notify',
		lazy = false,
		after = function()
			vim.notify = require('notify')
		end,
	},
	{
		'nvim-autopairs',
		event = { 'InsertEnter' },
		after = function()
			require('nvim-autopairs').setup {}
		end,
	},
	{
		'nvim-lspconfig',
		event = { 'VimEnter' },
	},
	{
		'copilot.vim',
	},
	{
		'volt',
	},
	{ 'nvim-web-devicons' },
	{
		'plenary.nvim',
		event = { 'VimEnter' },
	},
}
