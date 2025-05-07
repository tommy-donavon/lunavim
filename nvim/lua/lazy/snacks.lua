local cfg = {
  animate = {
    enable = true,
    duration = 20,
    easing = 'linear',
    fps = 60,
  },
  bigfile = { enable = true },
  image = { enable = true },
  dashboard = {
    enable = true,
    width = 60,
    pane_gap = 5,
    preset = {
      keys = {
        {
          icon = ' ',
          key = 'r',
          desc = 'Recent Files',
          action = ':lua Snacks.dashboard.pick("oldfiles")',
        },
        {
          icon = ' ',
          key = 'p',
          desc = 'List Projects',
          action = ':lua Snacks.dashboard.pick("projects")',
        },
        {
          icon = ' ',
          key = 'f',
          desc = 'Find File',
          action = ':lua Snacks.dashboard.pick("find_files")',
        },
        {
          icon = '󰊄 ',
          key = 't',
          desc = 'Find Text',
          action = ':lua Snacks.dashboard.pick("live_grep")',
        },
        {
          icon = '󰒲 ',
          key = 'L',
          desc = 'Lazy',
          action = ':Lazy',
          enabled = (package.loaded.lazy ~= nil),
        },
        {
          icon = ' ',
          key = 'q',
          desc = 'Quit',
          action = ':qa',
        },
      },
      header = [[
          _____            _____                    _____                    _____                    _____                    _____                    _____          
         /\    \          /\    \                  /\    \                  /\    \                  /\    \                  /\    \                  /\    \         
        /::\____\        /::\____\                /::\____\                /::\    \                /::\____\                /::\    \                /::\____\        
       /:::/    /       /:::/    /               /::::|   |               /::::\    \              /:::/    /                \:::\    \              /::::|   |        
      /:::/    /       /:::/    /               /:::::|   |              /::::::\    \            /:::/    /                  \:::\    \            /:::::|   |        
     /:::/    /       /:::/    /               /::::::|   |             /:::/\:::\    \          /:::/    /                    \:::\    \          /::::::|   |        
    /:::/    /       /:::/    /               /:::/|::|   |            /:::/__\:::\    \        /:::/____/                      \:::\    \        /:::/|::|   |        
   /:::/    /       /:::/    /               /:::/ |::|   |           /::::\   \:::\    \       |::|    |                       /::::\    \      /:::/ |::|   |        
  /:::/    /       /:::/    /      _____    /:::/  |::|   | _____    /::::::\   \:::\    \      |::|    |     _____    ____    /::::::\    \    /:::/  |::|___|______  
 /:::/    /       /:::/____/      /\    \  /:::/   |::|   |/\    \  /:::/\:::\   \:::\    \     |::|    |    /\    \  /\   \  /:::/\:::\    \  /:::/   |::::::::\    \ 
/:::/____/       |:::|    /      /::\____\/:: /    |::|   /::\____\/:::/  \:::\   \:::\____\    |::|    |   /::\____\/::\   \/:::/  \:::\____\/:::/    |:::::::::\____\
\:::\    \       |:::|____\     /:::/    /\::/    /|::|  /:::/    /\::/    \:::\  /:::/    /    |::|    |  /:::/    /\:::\  /:::/    \::/    /\::/    / ~~~~~/:::/    /
 \:::\    \       \:::\    \   /:::/    /  \/____/ |::| /:::/    /  \/____/ \:::\/:::/    /     |::|    | /:::/    /  \:::\/:::/    / \/____/  \/____/      /:::/    / 
  \:::\    \       \:::\    \ /:::/    /           |::|/:::/    /            \::::::/    /      |::|____|/:::/    /    \::::::/    /                       /:::/    /  
   \:::\    \       \:::\    /:::/    /            |::::::/    /              \::::/    /       |:::::::::::/    /      \::::/____/                       /:::/    /   
    \:::\    \       \:::\__/:::/    /             |:::::/    /               /:::/    /        \::::::::::/____/        \:::\    \                      /:::/    /    
     \:::\    \       \::::::::/    /              |::::/    /               /:::/    /          ~~~~~~~~~~               \:::\    \                    /:::/    /     
      \:::\    \       \::::::/    /               /:::/    /               /:::/    /                                     \:::\    \                  /:::/    /      
       \:::\____\       \::::/    /               /:::/    /               /:::/    /                                       \:::\____\                /:::/    /       
        \::/    /        \::/____/                \::/    /                \::/    /                                         \::/    /                \::/    /        
         \/____/          ~~                       \/____/                  \/____/                                           \/____/                  \/____/         
                                                                                                                                                                       
      ]],
    },
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
      {
        align = 'center',
        text = (function()
          local version = vim.version()
          local parsed_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
          local datetime = os.date('%Y/%m/%d %H:%M')
          return parsed_version .. ' -- ' .. datetime
        end)(),
      },
    },
  },
  lazygit = {
    enable = true,
    configure = true,
  },
  picker = {
    sources = {
      files = {
        hidden = true,
        ignored = false,
      },
    },
    toggles = {
      follow = 'f',
      hidden = 'h',
      ignored = 'i',
      modified = 'm',
      regex = {
        icon = 'R',
        value = false,
      },
    },
    explorer = {
      finder = 'rg',
      sort = {
        fields = {
          'sort',
        },
      },
      tree = true,
      supports_live = true,
      follow_file = true,
      focus = 'list',
      auto_close = false,
      jump = {
        close = false,
      },
      layout = {
        preset = 'sidebar',
        preview = false,
      },
      formatters = {
        file = {
          filename_only = true,
        },
      },
      matcher = {
        sort_empty = true,
      },
      config = function(opts)
        return require('snacks.picker.source.explorer').setup(opts)
      end,
      win = {
        list = {
          keys = {
            ['<BS>'] = 'explorer_up',
            ['a'] = 'explorer_add',
            ['d'] = 'explorer_del',
            ['r'] = 'explorer_rename',
            ['c'] = 'explorer_copy',
            ['m'] = 'explorer_move',
            ['y'] = 'explorer_yank',
            ['<c-c>'] = 'explorer_cd',
            ['.'] = 'explorer_focus',
          },
        },
      },
    },
  },
  statuscolumn = {
    enabled = true,
    left = {
      'mark',
      'sign',
    },
    right = {
      'fold',
      'git',
    },
    folds = {
      open = false,
      git_hl = false,
    },
    git = {
      patterns = {
        'GitSign',
        'MiniDiffSign',
      },
    },
    refresh = 50,
  },
  scroll = {
    enable = true,
  },
  terminal = {
    enable = true,
    win = {
      style = 'terminal',
    },
  },
  zen = {
    enable = true,
  },
}

return {
  'snacks.nvim',
  priority = 1000,
  lazy = false,
  after = function()
    local snacks = require('snacks')
    local wk = require('which-key')
    snacks.setup(cfg)
    local picker = snacks.picker
    wk.add {
      {
        mode = { 'n' },
        {
          '<leader>sk',
          picker.keymaps,
          desc = '[s]earch [k]eymaps',
        },
        {
          '<leader>sf',
          picker.files,
          desc = '[s]earch [f]iles',
        },
        {
          '<leader>sg',
          picker.grep,
          desc = '[s]earch by [g]rep',
        },
        {
          '<leader>sd',
          picker.diagnostics,
          desc = '[s]earch [d]iagnostics',
        },
        {
          '<leader>sr',
          picker.recent,
          desc = '[s]earch [r]ecent files',
        },
        {
          '<leader><leader>',
          picker.buffers,
          desc = '[] find existing buffers',
        },
        {
          '<leader>sh',
          picker.help,
          desc = '[s]earch [h]elp',
        },
      },
      {
        mode = { 'n', 'v' },
        {
          '<leader>tt',
          snacks.terminal.toggle,
          desc = '[t]oggle [t]erminal',
        },
        {
          '<leader>tf',
          picker.explorer,
          desc = '[t]oggle [f]ile explorer',
          silent = true,
        },
        {
          '<leader>tg',
          snacks.lazygit.open,
          desc = '[t]oggle Lazy [g]it',
        },
        {
          '<leader>tz',
          snacks.zen.zen,
          desc = '[t]oggle [z]en mode',
        },
      },
    }
  end,
}
