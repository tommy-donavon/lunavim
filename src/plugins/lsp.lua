local blink = require('blink.cmp')
local ih = require('inlay-hints')
local lspconfig = require('lspconfig')

local default_opt = {
  capabilities = blink.get_lsp_capabilities(),
  autostart = true,
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(_, bufnr)
    local buf_set_option
    buf_set_option = function(...)
      ---@diagnostic disable-next-line: deprecated
      return vim.api.nvim_buf_set_option(bufnr, ...)
    end
    return buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
}
local servers = {
  astro = {
    filetypes = { 'astro' },
    root_dir = lspconfig.util.root_pattern('astro.config.mjs'),
  },
  phpactor = {
    root_dir = lspconfig.util.root_pattern('composer.json'),
  },
  lua_ls = {
    cmd = {
      'lua-language-server',
    },
    filetypes = {
      'lua',
    },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          special = {
            reload = 'require',
          },
        },
        workspace = {
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
            vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
            '${3rd}/luv/library',
          },
        },
      },
    },
  },
  ts_ls = {
    root_dir = lspconfig.util.root_pattern('package.json'),
    single_file_support = false,
  },
  denols = {
    root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
    single_file_support = false,
  },
  eslint = {
    settings = {
      workingDirectories = {
        mode = 'auto',
      },
    },
  },
  hls = {},
  nil_ls = {
    cmd = {
      'nil',
    },
    filetypes = {
      'nix',
    },
    root_dir = lspconfig.util.root_pattern('flake.nix', '.git'),
  },
  elixirls = {
    cmd = {
      'elixir-ls',
    },
    filetypes = {
      'elixir',
    },
    root_dir = lspconfig.util.root_pattern('mix.exs', '.git'),
  },
  typos_lsp = {
    cmd_env = {
      RUST_LOG = 'error',
    },
    init_options = {
      diagnosticSeverity = 'Error',
    },
  },
  graphql = {
    filetypes = {
      'gql',
      'graphql',
    },
  },
  golangci_lint_ls = {},
  gopls = {
    cmd = {
      'gopls',
    },
    filetypes = {
      'go',
      'gomod',
    },
    on_attach = function(c, b)
      return ih.on_attach(c, b)
    end,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          url = 'https://www.schemastore.org/api/json/catalog.json',
          enable = true,
        },
        schemas = {
          kubernetes = '*.yaml',
          ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
          ['https://atmos.tools/schemas/atmos/atmos-manifest/1.0/atmos-manifest.json'] = 'stacks/**/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
          ['http://json.schemastore.org/circleciconfig'] = '.circleci/config.{yml,yaml}',
          ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
          ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.{yml,yaml}',
          ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
        },
      },
    },
  },
  terraformls = {},
  tflint = {},
  zls = {},
}

return {
  'nvim-lspconfig',
  lazy = true,
  event = { 'BufReadPost', 'BufNewFile', 'BufWinEnter' },
  after = function()
    ih.setup()

    for server, opt in pairs(servers) do
      lspconfig[server].setup(vim.tbl_deep_extend('force', {}, default_opt, opt))
    end
  end,
}
