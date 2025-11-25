-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/css.lua
--------------------------------------------------------------------------------

vim.bo.commentstring = "/* %s */" -- add spaces

--------------------------------------------------------------------------------
local bkeymap = require("config.utils").bufKeymap

bkeymap("n", "<leader>!", function()
	local line = vim.api.nvim_get_current_line()
	if line:find("!important") then
		line = line:gsub(" ?!important", "")
	else
		line = line:gsub(";?$", " !important;", 1)
	end
	vim.api.nvim_set_current_line(line)
end, { desc = "Toggle !important" })
