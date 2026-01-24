-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/
--------------------------------------------------------------------------------

vim.keymap.set("n", "q", vim.cmd.bdelete, { desc = "Quit", nowait = true, buffer = true })
