local U = require('utils')

return {

  -- Detect ts and sw automatically
  {
    'tpope/vim-sleuth'
  },

  -- Complementary [ and ] mappings
  {
    'tpope/vim-unimpaired'
  },

  -- Text alignment
  {
    'junegunn/vim-easy-align',
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign", mode = "n" },
      { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign", mode = "x" },
    }
  },

  -- Colorizer
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      '*'; -- Highlight all files, but customize some others.
      css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
      html = { names = false; } -- Disable parsing "names" like Blue or Gray
    }
  },

  -- Edit surrounding text
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  -- Undo history
  {
    'mbbill/undotree',
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree", mode = "n" },
    }
  },

  -- Hex edit for binary files
  {
    'RaafatTurki/hex.nvim',
    opts = {
      -- cli command used to dump hex data
      dump_cmd = 'xxd -g 1 -u',

      -- cli command used to assemble from hex data
      assemble_cmd = 'xxd -r',

      -- function that runs on BufReadPre to determine if it's binary or not
      -- is_file_binary_pre_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
      -- end,

      -- function that runs on BufReadPost to determine if it's binary or not
      -- is_file_binary_post_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
      -- end,
    }
  },

  -- Quickfix list enhancements
  {
    'kevinhwang91/nvim-bqf'
  },

  -- Enhanced Search/Replace
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {
      {
        "<leader>fR",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = "[F]ind and [R]eplace (interactive)",
      },
    },
  },

  -- Fold enhancements
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {}, -- needed even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldmethod = "expr"

      -- :h vim.treesitter.foldexpr()
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- ref: https://github.com/neovim/neovim/pull/20750
      vim.opt.foldtext = ""
      vim.opt.fillchars:append("fold: ")

      -- Open all folds by default, zm is not available
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

}

