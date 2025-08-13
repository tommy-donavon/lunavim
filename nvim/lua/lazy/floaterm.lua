require('which-key').add {
	mode = { 'n', 'v' },
	{
		{
			'<leader>tt',
			function()
				vim.cmd('FloatermToggle')
			end,
			desc = '[t]oggle [t]erminal',
		},
	},
}

return {
	'floaterm',
	cmd = 'FloatermToggle',
	after = function()
		local ft = require('floaterm')
		ft.setup {
			border = false,
			size = { h = 60, w = 70 },

			mappings = { sidebar = nil, term = nil },

			terminals = {
				{ name = 'Terminal' },
			},
		}
	end,
}
