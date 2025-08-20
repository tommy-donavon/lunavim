return {
	'go.nvim',
	event = { 'CmdlineEnter' },
	ft = { 'go', 'gomod' },
	enabled = vim.fn.executable('go') == 1,
	after = function()
		require('go').setup {}

		vim.api.nvim_create_autocmd('BufWritePre', {
			pattern = '*.go',
			callback = function()
				---@diagnostic disable-next-line: missing-parameter
				local params = vim.lsp.util.make_range_params()
				---@diagnostic disable-next-line: inject-field
				params.context = { only = { 'source.organizeImports' } }
				local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
				for cid, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
							vim.lsp.util.apply_workspace_edit(r.edit, enc)
						end
					end
				end
				vim.lsp.buf.format { async = false }
			end,
		})
	end,
}
