-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/
--------------------------------------------------------------------------------

vim.opt_local.listchars:remove("multispace") -- spacing in comments

local bkeymap = require("config.utils").bufKeymap
bkeymap("n", "<CR>", "ZZ", { desc = " Confirm" })     -- quit with saving = confirm
bkeymap("n", "q", vim.cmd.cquit, { desc = " Abort" }) -- quit with error  = aborting

-- HIGHLIGHTS
-- applies to whole window, but since that window is closed anyway, it's not a problem
vim.fn.matchadd("Number", [[#\d\+]]) -- issue numbers
vim.fn.matchadd("@markup.raw.markdown_inline", [[`.\{-}`]]) -- inline code, `.\{-}` = non-greedy quantifier
vim.fn.matchadd("NonText", [[\v^d(rop)? .*]]) -- `drop` action (or short form `d`)
