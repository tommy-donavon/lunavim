return {
	'hover.nvim',
	after = function()
		local hover = require('hover')
		local wk = require('which-key')
		hover.setup {
			init = function()
				return require('hover.providers.lsp')
			end,
			preview_opts = { border = 'single' },
			preview_window = false,
			title = true,
			mouse_providers = { 'LSP' },
			mouse_delay = 1000,
		}
		vim.o.mousemoveevent = true
		return wk.add {
			mode = { 'n' },
			{
				'K',
				hover.hover,
				desc = 'hover.nvim',
			},
			{
				'gK',
				hover.hover_select,
				desc = 'hover.nvim (select)',
			},
			{
				'<C-p>',
				function()
					return hover.hover_switch('previous')
				end,
				desc = 'hover.nvim (previous source)',
			},
			{
				'<C-n>',
				function()
					return hover.hover_switch('next')
				end,
				desc = 'hover.nvim (next source)',
			},
			{
				'<MouseMove>',
				hover.hover_mouse,
				desc = 'hover.nvim (mouse)',
			},
		}
	end,
}
