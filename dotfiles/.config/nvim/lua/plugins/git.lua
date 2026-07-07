local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

local function diffget(stage)
  vim.cmd("diffget //" .. stage)
  vim.cmd.diffupdate()
end

local function nav_change(direction)
  if vim.wo.diff then
    vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true })
  else
    require("gitsigns").nav_hunk(direction, { target = "all" })
  end
end

local function confirm(message, action)
  if vim.fn.confirm(message, "&Yes\n&No", 2) == 1 then
    action()
  end
end

local function hunk_range()
  return { vim.fn.line("."), vim.fn.line("v") }
end

-- git difftool keymaps
map("n", "<leader>[", function() diffget(2) end, "Git diffget ours")
map("n", "<leader>]", function() diffget(3) end, "Git diffget theirs")

map("n", "<leader>gn", function() nav_change("next") end, "Git next hunk")
map("n", "<leader>gp", function() nav_change("prev") end, "Git previous hunk")
map("n", "<leader>go", function() diffget(2) end, "Git take ours")
map("n", "<leader>gt", function() diffget(3) end, "Git take theirs")
map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, "Git stage hunk")
map("v", "<leader>gs", function() require("gitsigns").stage_hunk(hunk_range()) end, "Git stage selection")
map("n", "<leader>gS", function() require("gitsigns").stage_buffer() end, "Git stage buffer")
map("n", "<leader>gr", function()
  confirm("Reset current hunk?", function() require("gitsigns").reset_hunk() end)
end, "Git reset hunk")
map("v", "<leader>gr", function()
  confirm("Reset selected lines?", function() require("gitsigns").reset_hunk(hunk_range()) end)
end, "Git reset selection")
map("n", "<leader>gR", function()
  confirm("Reset all hunks in this buffer?", function() require("gitsigns").reset_buffer() end)
end, "Git reset buffer")
map("n", "<leader>gv", function() require("gitsigns").preview_hunk() end, "Git preview hunk")
map("n", "<leader>gV", function() require("gitsigns").preview_hunk_inline() end, "Git preview hunk inline")
map("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, "Git blame line")
map("n", "<leader>gd", function() require("gitsigns").diffthis() end, "Git diff file")
map("n", "<leader>gD", function() require("gitsigns").diffthis("~") end, "Git diff file against HEAD~1")
map("n", "<leader>gq", function() require("gitsigns").setqflist() end, "Git hunks to quickfix")
map("n", "<leader>gQ", function() require("gitsigns").setqflist("all") end, "Git all hunks to quickfix")
map({ "o", "x" }, "ih", function() require("gitsigns").select_hunk() end, "Git hunk")

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
