return {
	'blink-cmp',
	after = function()
		local blink = require('blink.cmp')
		return blink.setup {
			keymap = {
				preset = 'default',
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
			},
			fuzzy = {
				prebuilt_binaries = {
					download = false,
				},
			},
			sources = {
				default = {
					'lazydev',
					'buffer',
					'lsp',
					'path',
					'snippets',
				},
				providers = {
					lazydev = {
						name = 'LazyDev',
						module = 'lazydev.integrations.blink',
						score_offset = 100,
					},
				},
			},
		}
	end,
}
