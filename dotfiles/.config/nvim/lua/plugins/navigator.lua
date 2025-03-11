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
      { "<C-Left>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-Right>", "<cmd>TmuxNavigateRight<cr>" },
      { "<C-Up>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-Down>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  }
}
