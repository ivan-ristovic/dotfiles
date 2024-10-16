local U = require('utils')

return {

  -- Detect ts and sw automatically
  {
    'tpope/vim-sleuth'
  },

  -- Text alignment
  {
    'junegunn/vim-easy-align',
    command = function ()
      U.keymap("n", "ga", "<Plug>(EasyAlign)", "Align")
      U.keymap("x", "ga", "<Plug>(EasyAlign)", "Align")
    end
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
  },

  -- Undo history
  {
    'mbbill/undotree',
    init = function ()
      U.keymap("n", "<leader>u", ":UndotreeToggle<cr>", "Toggle undotree")
    end
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
  }

}
