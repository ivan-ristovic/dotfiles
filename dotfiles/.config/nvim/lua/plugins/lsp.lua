-- LSP

return {

  {
    'neovim/nvim-lspconfig',

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
      "folke/neodev.nvim",
      -- Highlight symbols under cursor
      "RRethy/vim-illuminate",
    },

    config = function ()

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- Turn on LSP status information
      require("fidget").setup()

      -- Setup mason so it can manage external tooling
      require('mason').setup()

      -- Enable the following language servers
      -- Commented ones should be installed manually
      local servers = {
        'bashls',                           -- bash lsp
        'clangd',                           -- clang lsp
        --[[ 'cpplint',                          -- cpp linter ]]
        'dockerls',                          -- docker lsp
        'docker_compose_language_service',  -- docker-compose lsp
        --[[ 'editorconfig-checker',             -- .editorconfig check  ]]
        'html',                             -- html lsp
        --[[ 'java_language_server',             -- java lsp ]]
        'jsonls',                           -- json lsp
        'lemminx',                          -- xml lsp
        'lua_ls',                           -- lua lsp and linter
        'marksman',                         -- markdown lsp
        --[[ 'misspell',                         -- english word correction ]]
        --[[ 'pylint',                           -- python linter ]]
        'jedi_language_server',             -- python lsp
        'pyright',                          -- python static type checker 
        'rust_analyzer',                    -- rust lsp
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
      local on_attach = function(_, bufnr)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('<leader>l', vim.diagnostic.open_float)
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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
      end


      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      for _, lsp in ipairs(servers) do
        require('lspconfig')[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

    end     -- end config
  }

}
