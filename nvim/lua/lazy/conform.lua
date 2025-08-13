return {
	'conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	after = function()
		local conform = require('conform')

		conform.setup {
			keys = {},
			formatters_by_ft = {
				blade = { 'blade-formatter' },
				elixir = { 'mix' },
				javascript = {
					'biome',
					'biome-check',
					'biome-organize-imports',
					'eslint_d',
					'prettierd',
					'prettier',
					stop_after_first = true,
				},
				json = { 'prettierd', 'prettier', stop_after_first = false },
				lua = { 'stylua' },
				nix = { 'nixfmt' },
				python = { 'black', stop_after_first = true },
				ruby = { 'rubocop', 'solargraph' },
				svelte = { 'eslint_d', 'prettierd', 'prettier', stop_after_first = false },
				terraform = { 'terraform_fmt' },
				typescript = {
					'biome',
					'biome-check',
					'biome-organize-imports',
					'eslint_d',
					'prettierd',
					'prettier',
					stop_after_first = false,
				},
				yaml = { 'yamlfix' },
			},
			notify_on_error = true,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = 'never'
				else
					lsp_format_opt = 'fallback'
				end
				return {
					lsp_format = lsp_format_opt,
				}
			end,
		}

		vim.keymap.set({ 'n', 'v' }, '<leader>fr', function()
			conform.format {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			}
		end, { desc = '[F]ormat file or range (in visual mode)' })

		vim.keymap.set('n', '<leader>ff', function()
			conform.format { async = true, lsp_format = 'fallback' }
		end)
	end,
}
