local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- git difftool keymaps
keymap("n", "<leader>[", ":diffget //2<cr>", opts)
keymap("n", "<leader>]", ":diffget //3<cr>", opts)

return {

  -- Git integration
  {
    'tpope/vim-fugitive'
  },

  -- Git indication sidebar
  {
    'lewis6991/gitsigns.nvim',

    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '│' },
        topdelete    = { text = '│' },
        changedelete = { text = '│' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 5000,
        follow_files = true
      },
      auto_attach = true,
      on_attach = function (buffer)
        vim.api.nvim_command("highlight GitSignsAdd guibg=None guifg=LightGreen")
        vim.api.nvim_command("highlight GitSignsChange guibg=None guifg=Teal")
        vim.api.nvim_command("highlight GitSignsDelete guibg=None guifg=Red")
      end,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 5000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    }       -- end opts
  }

}
