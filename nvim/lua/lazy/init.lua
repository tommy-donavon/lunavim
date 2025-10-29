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
	{ 'nvim-web-devicons' },
	{
		'plenary.nvim',
		event = { 'VimEnter' },
	},
	{
		'nightfox.nvim',
		lazy = false,
		priority = 1000,
		after = function()
			vim.cmd('colorscheme nightfox')
		end,
	},
	{
		'hardtime.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		after = function()
			require('hardtime').setup()
		end,
	},
}
