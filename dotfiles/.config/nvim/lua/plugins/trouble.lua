-- Diagnostics, LSP, qfix lists
return {

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<C-X>a",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (all buffers)",
      },
      {
        "<C-X>c",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Diagnostics (current buffer)",
      },
      {
        "<leader>s",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Diagnostics Focus (Trouble)",
      },
      {
        "<C-X>l",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Diagnostics LSP Definitions / references / ...",
      },
      {
        "<C-X>L",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Diagnostics Location List",
      },
      {
        "<C-X>q",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Diagnostics Quickfix List (Trouble)",
      },
    },
  }

}
