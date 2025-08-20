return {
	'rustaceanvim',
	lazy = false,
	enabled = vim.fn.executable('rustc') == 1,
	after = function()
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					['rust-analyzer'] = {
						files = {
							excludeDirs = {
								'.cargo',
								'.direnv',
								'.git',
								'target',
							},
						},
					},
				},
			},
		}
	end,
}
