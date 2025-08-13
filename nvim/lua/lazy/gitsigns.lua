return {
	'gitsigns.nvim',
	after = function()
		local gitsigns = require('gitsigns')
		local cfg = {
			signs = {
				add = {
					text = '┃',
				},
				change = {
					text = '┃',
				},
				delete = {
					text = '_',
				},
				topdelete = {
					text = '‾',
				},
				changedelete = {
					text = '~',
				},
				untracked = {
					text = '┆',
				},
			},
			signs_staged = {
				add = {
					text = '┃',
				},
				change = {
					text = '┃',
				},
				delete = {
					text = '_',
				},
				topdelete = {
					text = '‾',
				},
				changedelete = {
					text = '~',
				},
				untracked = {
					text = '┆',
				},
			},
			signs_staged_enable = true,
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol',
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = 'single',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1,
			},

			on_attach = function(bufnr)
				local map = function(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					return vim.keymap.set(mode, l, r, opts)
				end

				map('n', ']c', function()
					if vim.wo.diff then
						return vim.cmd.normal {
							']c',
							bang = true,
						}
					else
						return gitsigns.nav_hunk('next')
					end
				end, { desc = 'Next Git hunk' })

				map('n', '[c', function()
					if vim.wo.diff then
						return vim.cmd.normal {
							'[c',
							bang = true,
						}
					else
						return gitsigns.nav_hunk('prev')
					end
				end, { desc = 'Previous Git hunk' })

				map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Git hunk' })
				map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Git hunk' })

				map('v', '<leader>gs', function()
					return gitsigns.stage_hunk {
						vim.fn.line('.'),
						vim.fn.line('v'),
					}
				end, { desc = 'Stage Git hunk (visual)' })

				map('v', '<leader>gr', function()
					return gitsigns.reset_hunk {
						vim.fn.line('.', vim.fn.line('v')),
					}
				end, { desc = 'Reset Git hunk (visual)' })

				map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
				map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
				map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
				map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview Git hunk' })

				map('n', '<leader>gb', function()
					return gitsigns.blame_line {
						full = true,
					}
				end, { desc = 'Blame line' })

				map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle current line blame' })
				map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff this' })

				map('n', '<leader>gD', function()
					return gitsigns.diffthis('~')
				end, { desc = 'Diff this (HEAD)' })

				map('n', '<leader>td', gitsigns.toggle_deleted)
				return map({
					'o',
					'x',
				}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Toggle select hunk' })
			end,
		}

		gitsigns.setup(cfg)
	end,
}
