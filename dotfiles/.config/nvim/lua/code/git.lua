local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>[", ":diffget //2<cr>", opts)
keymap("n", "<leader>]", ":diffget //3<cr>", opts)
