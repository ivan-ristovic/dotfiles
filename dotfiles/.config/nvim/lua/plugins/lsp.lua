-- LSP

return {

  {
    'neovim/nvim-lspconfig',

    opts = {
      inlay_hints = {
        enabled = true
      },
    },

    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        event = "LspAttach"
      },
      -- LuaLS
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      -- Highlight symbols under cursor
      'RRethy/vim-illuminate',
      -- Better method overloads
      'Issafalcon/lsp-overloads.nvim',
    },

    config = function ()

      -- Turn on LSP status information
      require("fidget").setup({})

      -- Setup mason so it can manage external tooling
      require('mason').setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

      -- Enable the following language servers
      -- Commented ones should be installed manually
      local servers = {
        'bashls',                           -- bash lsp
        'clangd',                           -- C/C++ lsp
        'cmake',                            -- CMake lsp
        'cssls',                            -- CSS lsp
        'dockerls',                         -- docker lsp
        'docker_compose_language_service',  -- docker-compose lsp
        'gradle_ls',                        -- gradle lsp
        --[[ 'editorconfig-checker',             -- .editorconfig check  ]]
        'html',                             -- html lsp
        'jdtls',                            -- java lsp
        'jsonls',                           -- json lsp
        'lemminx',                          -- xml lsp
        'lua_ls',                           -- lua lsp and linter
        'marksman',                         -- markdown lsp
        --[[ 'misspell',                         -- english word correction ]]
        --[[ 'pylint',                           -- python linter ]]
        --[[ 'omnisharp',                        -- csharp lsp ]]
        'pyright',                          -- python static type checker 
        --[[ 'shellcheck',                       -- bash static analysis ]]
        --[[ 'shfmt',                            -- bash formatter ]]
        'texlab',                           -- latex lsp
        'yamlls',                           -- yml/yaml linter 
      }

      -- Ensure the servers above are installed
      require('mason-lspconfig').setup {
        ensure_installed = servers,
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        if client.server_capabilities.signatureHelpProvider then
          require('lsp-overloads').setup(client, {
            ui = {
              close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
              floating_window_above_cur_line = true,
              border = "single",
            },
            keymaps = {
              next_signature = "<Down>",
              previous_signature = "<Up>",
              next_parameter = "<Right>",
              previous_parameter = "<Left>",
              close_signature = "<A-CR>"
            },
            display_automatically = false,
          })
          vim.api.nvim_set_keymap("n", "<A-CR>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("i", "<A-CR>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('<leader>l', vim.diagnostic.open_float)
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          if vim.lsp.buf.format then
            vim.lsp.buf.format()
          elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
          end
        end, { desc = 'Format current buffer with LSP' })
        
        -- LSP color info square
        -- Disabled until neovim update: 
        -- https://github.com/neovim/neovim/pull/33440/files#diff-6b5f3071d65558aab177912061ac6a2f5312660655a449276c83697686f28e72
        --[[ if client:supports_method('textDocument/documentColor') then ]]
        --[[   vim.lsp.document_color.enable(true, bufnr, { style = 'virtual' }) ]]
        --[[ end ]]

      end

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

    end     -- end config
  },

  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  }

}
