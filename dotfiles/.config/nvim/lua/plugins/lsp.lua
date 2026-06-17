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
      -- Mason LSP integration. General CLI tools live in plugins/mason.lua. 
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
      {
        'RRethy/vim-illuminate',
        config = function()
          require('illuminate').configure({
            providers = { 'lsp', 'regex' },
          })
        end,
      },
      -- Better method overloads
      'Issafalcon/lsp-overloads.nvim',
    },

    config = function ()

      -- Turn on LSP status information
      require("fidget").setup({
        notification = {
          window = {
            avoid = { "NvimTree" },
          },
        },
      })

      local mason = require("mason")
      if not mason.has_setup then
        mason.setup()
      end

      -- Enable the following language servers
      local servers = {
        'bashls',                           -- bash lsp
        'clangd',                           -- C/C++ lsp
        'cssls',                            -- CSS lsp
        'dockerls',                         -- docker lsp
        'docker_compose_language_service',  -- docker-compose lsp
        'gradle_ls',                        -- gradle lsp
        'html',                             -- html lsp
        'jdtls',                            -- java lsp
        'jsonls',                           -- json lsp
        'lemminx',                          -- xml lsp
        'lua_ls',                           -- lua lsp and linter
        'marksman',                         -- markdown lsp
        'omnisharp',                        -- csharp lsp
        'pyright',                          -- python static type checker 
        'texlab',                           -- latex lsp
        'yamlls',                           -- yml/yaml linter 
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
        if vim.lsp.document_color and client:supports_method('textDocument/documentColor') then
          vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = 'virtual' })
        end

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

      require('mason-lspconfig').setup {
        ensure_installed = servers,
        automatic_enable = false,
      }

      vim.lsp.enable(servers)

      -- signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

    end     -- end config
  },

}
