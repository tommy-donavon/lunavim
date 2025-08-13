return {
	'smear-cursor.nvim',
	after = function()
		local smear = require('smear_cursor')

		smear.setup {
			legacy_computing_symbols_support = true,
			scroll_buffer_space = true,
			smear_between_buffers = true,
			smear_between_neighbor_lines = true,
			stiffness = 0.8,
			trailing_stiffness = 0.5,
			distance_stop_animating = 0.5,
			hide_target_hack = false,
		}
	end,
}
