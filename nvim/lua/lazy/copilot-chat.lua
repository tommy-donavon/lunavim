-- reference: https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat-v2.lua

local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  'CopilotChat.nvim',
  after = function()
    local chat = require('CopilotChat')

    chat.setup {
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      prompts = prompts,
      model = 'claude-3.7-sonnet',
      mappings = {
        -- Use tab for completion
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        -- Close the chat
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
        },
        -- Accept the diff
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        -- Show help
        show_help = {
          normal = 'g?',
        },
      },
    }
    local select = require('CopilotChat.select')
    vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = '*', range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command('CopilotChatInline', function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = '*', range = true })

    -- Restore CopilotChatBuffer
    vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = '*', range = true })

    -- Custom buffer for CopilotChat
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true

        -- Get current filetype and set it to markdown if the current filetype is copilot-chat
        local ft = vim.bo.filetype
        if ft == 'copilot-chat' then
          vim.bo.filetype = 'markdown'
        end
      end,
    })

    local mcp = require('mcphub')
    mcp.on({ 'servers_updated', 'tool_list_changed', 'resource_list_changed' }, function()
      local hub = mcp.get_hub_instance()
      if not hub then
        return
      end

      local async = require('plenary.async')
      local call_tool = async.wrap(function(server, tool, input, callback)
        hub:call_tool(server, tool, input, {
          callback = function(res, err)
            callback(res, err)
          end,
        })
      end, 4)

      local access_resource = async.wrap(function(server, uri, callback)
        hub:access_resource(server, uri, {
          callback = function(res, err)
            callback(res, err)
          end,
        })
      end, 3)

      for name, tool in pairs(chat.config.functions) do
        if tool.id and tool.id:sub(1, 3) == 'mcp' then
          chat.config.functions[name] = nil
        end
      end
      local resources = hub:get_resources()
      for _, resource in ipairs(resources) do
        local name = resource.name:lower():gsub(' ', '_'):gsub(':', '')
        chat.config.functions[name] = {
          id = 'mcp:' .. resource.server_name .. ':' .. name,
          uri = resource.uri,
          description = type(resource.description) == 'string' and resource.description or '',
          resolve = function()
            local res, err = access_resource(resource.server_name, resource.uri)
            if err then
              error(err)
            end

            res = res or {}
            local result = res.result or {}
            local content = result.contents or {}
            local out = {}

            for _, message in ipairs(content) do
              if message.text then
                table.insert(out, {
                  uri = message.uri,
                  data = message.text,
                  mimetype = message.mimeType,
                })
              end
            end

            return out
          end,
        }
      end

      local tools = hub:get_tools()
      for _, tool in ipairs(tools) do
        chat.config.functions[tool.name] = {
          id = 'mcp:' .. tool.server_name .. ':' .. tool.name,
          group = tool.server_name,
          description = tool.description,
          schema = tool.inputSchema,
          resolve = function(input)
            local res, err = call_tool(tool.server_name, tool.name, input)
            if err then
              error(err)
            end

            res = res or {}
            local result = res.result or {}
            local content = result.content or {}
            local out = {}

            for _, message in ipairs(content) do
              if message.type == 'text' then
                table.insert(out, {
                  data = message.text,
                })
              elseif message.type == 'resource' and message.resource and message.resource.text then
                table.insert(out, {
                  uri = message.resource.uri,
                  data = message.resource.text,
                  mimetype = message.resource.mimeType,
                })
              end
            end

            return out
          end,
        }
      end
    end)
  end,
  keys = {
    {
      '<leader>ap',
      function()
        require('CopilotChat').select_prompt {
          context = {
            'buffers',
          },
        }
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    {
      '<leader>ap',
      function()
        require('CopilotChat').select_prompt()
      end,
      mode = 'x',
      desc = 'CopilotChat - Prompt actions',
    },
    -- Code related commands
    { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
    { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
    { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
    { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
    { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
    -- Chat with Copilot in visual mode
    {
      '<leader>av',
      ':CopilotChatVisual',
      mode = 'x',
      desc = 'CopilotChat - Open in vertical split',
    },
    {
      '<leader>ax',
      ':CopilotChatInline',
      mode = 'x',
      desc = 'CopilotChat - Inline chat',
    },
    -- Custom input for CopilotChat
    {
      '<leader>ai',
      function()
        local input = vim.fn.input('Ask Copilot: ')
        if input ~= '' then
          vim.cmd('CopilotChat ' .. input)
        end
      end,
      desc = 'CopilotChat - Ask input',
    },
    -- Generate commit message based on the git diff
    {
      '<leader>am',
      '<cmd>CopilotChatCommit<cr>',
      desc = 'CopilotChat - Generate commit message for all changes',
    },
    -- Quick chat with Copilot
    {
      '<leader>aq',
      function()
        local input = vim.fn.input('Quick Chat: ')
        if input ~= '' then
          vim.cmd('CopilotChatBuffer ' .. input)
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    -- Fix the issue with diagnostic
    { '<leader>af', '<cmd>CopilotChatFixError<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    -- Clear buffer and chat history
    { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
    -- Toggle Copilot Chat Vsplit
    { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
    -- Copilot Chat Models
    { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    -- Copilot Chat Agents
    { '<leader>aa', '<cmd>CopilotChatAgents<cr>', desc = 'CopilotChat - Select Agents' },
  },
}
