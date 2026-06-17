--[[ Utility functions for working with nvim configuaration.

The module is stored in the `core` package in order to minimize the chance of naming clashing
--]]


local M = {}

-----------------------------------------------------------
-- Checks if running under Windows.
-----------------------------------------------------------
function M.is_win()
    if vim.loop.os_uname().version:match('Windows') then
        return true
    else
        return false
    end
end

-----------------------------------------------------------
-- Function equivalent to basename in POSIX systems.
-- @param str the path string.
-----------------------------------------------------------
function M.basename(str)
  return string.gsub(str, "(.*/)(.*)", "%2")
end

-----------------------------------------------------------
-- Contatenates given paths with correct separator.
-- @param: var args of string paths to joon.
-----------------------------------------------------------
function M.join_paths(...)
    local path_sep = M.is_win() and '\\' or '/'
    local result = table.concat({ ... }, path_sep)
    return result
end

local _base_lua_path = M.join_paths(vim.fn.stdpath('config'), 'lua')

-----------------------------------------------------------
-- Loads all modules from the given package.
-- @param package: name of the package in lua folder.
-----------------------------------------------------------
function M.glob_require(package)
    local glob_path = M.join_paths(
      _base_lua_path,
      package,
      '*.lua'
    )

    for _, path in pairs(vim.fn.glob(glob_path, false, true)) do
        -- convert absolute filename to relative
        -- ~/.config/nvim/lua/<package>/<module>.lua => <package>.<module>
        local relfilename = path:sub(#_base_lua_path + 2, -5):gsub("[/\\]", ".")
        local basename = path:match("([^/\\]+)%.lua$") or ""
        -- skip `init` and files starting with underscore.
        if (basename ~= 'init' and basename:sub(1, 1) ~= '_') then
            require(relfilename)
        end
    end
end

function M.keymap(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.keymap_expr(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, expr = true, desc = desc }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

return M
