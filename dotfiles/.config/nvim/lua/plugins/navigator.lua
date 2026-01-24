return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      --[[ "TmuxNavigatePrevious", ]]
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<C-S-Left>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-S-Right>", "<cmd>TmuxNavigateRight<cr>" },
      { "<C-S-Up>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-S-Down>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-S-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
    init = function ()
      vim.g.tmux_navigator_no_mappings = 1
    end
  }
}
