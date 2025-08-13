return {
	'oil.nvim',
	lazy = false,
	after = function()
		local oil = require('oil')
		return oil.setup {
			default_file_explorer = true,
			columns = {
				'icon',
				'size',
			},
		}
	end,
}
