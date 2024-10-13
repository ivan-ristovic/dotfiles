-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer manages itself

    -- Appearance and general functionality
    use 'Mofiqul/vscode.nvim'       -- VSCode-like color scheme
    use 'nvim-lua/popup.nvim'       -- An implementation of the Popup API   
    use "akinsho/bufferline.nvim"   -- Buffer (tabs)
    use "sitiom/nvim-numbertoggle"  -- Absolute/Relative number autotoggle
    use "mbbill/undotree"           -- Undo history
    use "mg979/vim-visual-multi"    -- Multi-cursors
    use "j-hui/fidget.nvim"         -- Fidget with status updates 
    use 'RaafatTurki/hex.nvim'      -- Hex edit
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-media-files.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter" -- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Programming
    use 'tpope/vim-fugitive'                          -- Git
    use 'windwp/nvim-autopairs'                       -- Bracket autoindent and pairing
    use 'numToStr/Comment.nvim'                       -- Code comment
    use 'tpope/vim-sleuth'                            -- Detect ts and sw automatically
    use 'JoosepAlviste/nvim-ts-context-commentstring' -- Treesitter-guided comments
    use 'lukas-reineke/indent-blankline.nvim'         -- Line indendation
    use 'norcalli/nvim-colorizer.lua'                 -- CSS colors
    use 'junegunn/vim-easy-align'                     -- Alignment
    use 'lewis6991/gitsigns.nvim'                     -- Git indication
    use 'lervag/vimtex'
    use { 'sakhnik/nvim-gdb', run = './install.sh' }  -- Debugging support

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
    use "honza/vim-snippets"
    use "saadparwaiz1/cmp_luasnip"

    -- LSP 
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
        },
    }

    if is_bootstrap then
        require('packer').sync()
    end

end)

