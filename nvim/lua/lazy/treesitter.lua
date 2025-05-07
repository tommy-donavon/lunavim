local cfg = {
  autotag = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  auto_install = false,
  ignore_install = 'all',
  --parser_install_dir = parser_path,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = '.',
      scope_incremental = 'grc',
      node_decremental = ',',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ai'] = '@call.outer',
        ['ii'] = '@call.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = {
          query = '@class.outer',
          desc = 'Next class start',
        },
        [']o'] = '@loop.*',
        [']s'] = {
          query = '@scope',
          query_group = 'locals',
          desc = 'Next scope',
        },
        [']z'] = {
          query = '@fold',
          query_group = 'folds',
          desc = 'Next fold',
        },
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      goto_next = {
        [']d'] = '@conditional.outer',
      },
      goto_previous = {
        ['[d'] = '@conditional.outer',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ['<leader>sd'] = '@function.outer',
        ['<leader>sD'] = '@class.outer',
      },
    },
  },
}

return {
  'nvim-treesitter',
  event = { 'BufRead', 'BufNewFile' },
  after = function()
    local treesitter = require('nvim-treesitter.configs')
    return treesitter.setup(cfg)
  end,
}
