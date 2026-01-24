-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/
--------------------------------------------------------------------------------

-- python standard
vim.bo.expandtab = true
vim.bo.shiftwidth = 4

-- formatters prescribe comments being separated by two spaces
vim.opt_local.listchars:append { multispace = " " }
vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode

--------------------------------------------------------------------------------

-- VIRTUAL_ENV – auto-set
vim.defer_fn(function()
	local venv = (vim.uv.cwd() or "") .. "/.venv"
	if vim.uv.fs_stat(venv) then vim.env.VIRTUAL_ENV = venv end
end, 1)

--------------------------------------------------------------------------------
-- ABBREVIATIONS
local abbr = require("config.utils").bufAbbrev
abbr("true", "True")
abbr("false", "False")
abbr("//", "#")
abbr("--", "#")
abbr("null", "None")
abbr("nil", "None")
abbr("none", "None")
abbr("trim", "strip")
abbr("function", "def")

--------------------------------------------------------------------------------
-- KEYMAPS

local bkeymap = require("config.utils").bufKeymap

bkeymap("n", "<leader>ci", function()
	vim.lsp.buf.code_action {
		filter = function(a) return a.title:find("import") ~= nil end,
		apply = true,
	}
end, { desc = "Import word under cursor" })

