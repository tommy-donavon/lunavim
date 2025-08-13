return {
	'actions-preview.nvim',
	after = function()
		local actions_preview = require('actions-preview')
		actions_preview.setup {
			snacks = {
				layout = { preset = 'default' },
			},
		}
		vim.keymap.set({ 'v', 'n' }, 'gf', require('actions-preview').code_actions)
	end,
}
