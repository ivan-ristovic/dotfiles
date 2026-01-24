-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/
--------------------------------------------------------------------------------

vim.opt_local.listchars:remove("multispace") -- spacing in comments

local bkeymap = require("config.utils").bufKeymap
bkeymap("n", "<CR>", "ZZ", { desc = " Confirm" })     -- quit with saving = confirm
bkeymap("n", "q", vim.cmd.cquit, { desc = " Abort" }) -- quit with error  = aborting
