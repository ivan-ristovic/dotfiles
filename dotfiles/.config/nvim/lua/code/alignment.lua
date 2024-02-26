local opts = { noremap = false, silent = true }
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", opts)
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", opts)
