local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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
    
    -- Neovim general functionality and apperence
    use 'tomasiser/vim-code-dark'   -- VSCode-like color scheme
    use 'nvim-lua/popup.nvim'       -- An implementation of the Popup API   
    use "akinsho/bufferline.nvim"   -- Buffer (tabs)
    use "sitiom/nvim-numbertoggle"  -- Absolute/Relative number autotoggle
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
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter" -- Syntax highlighting

    -- Programming
    use "windwp/nvim-autopairs" -- Autopairs
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use 'lukas-reineke/indent-blankline.nvim' --shows line indendation
    use 'norcalli/nvim-colorizer.lua' --CSS colors
    use "lewis6991/gitsigns.nvim" --Git indication
    use "akinsho/toggleterm.nvim"

    -- Completion
    use "hrsh7th/nvim-cmp" -- completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- LSP completion for cmp

    -- LSP 
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- leungage server installer
    use "jose-elias-alvarez/null-ls.nvim" --formatters and linters

end)

