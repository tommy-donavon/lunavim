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
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        return vim.cmd.normal {
          '[c',
          bang = true,
        }
      else
        return gitsigns.nav_hunk('prev')
      end
    end)

    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      return gitsigns.stage_hunk {
        vim.fn.line('.'),
        vim.fn.line('v'),
      }
    end)

    map('v', '<leader>hr', function()
      return gitsigns.reset_hunk {
        vim.fn.line('.', vim.fn.line('v')),
      }
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)

    map('n', '<leader>hb', function()
      return gitsigns.blame_line {
        full = true,
      }
    end)

    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      return gitsigns.diffthis('~')
    end)

    map('n', '<leader>td', gitsigns.toggle_deleted)
    return map({
      'o',
      'x',
    }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}

return {
  'gitsigns.nvim',
  after = function()
    gitsigns.setup(cfg)
  end,
}
