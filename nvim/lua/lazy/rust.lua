--- only enable plugin if rust compiler is present in the environment
if vim.fn.executable('rustc') ~= 1 then
	return {}
end

return {
	'rustaceanvim',
	lazy = false,
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
