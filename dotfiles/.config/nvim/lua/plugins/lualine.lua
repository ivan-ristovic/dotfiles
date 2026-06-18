-- Status line

local E = require('external.environ')

local merge_roles = {
  ["1"] = "MERGE:BASE",
  ["2"] = "MERGE:LOCAL",
  ["3"] = "MERGE:REMOTE",
}

local function statusline_context()
  local winid = tonumber(vim.g.statusline_winid)
  if winid and vim.api.nvim_win_is_valid(winid) then
    return vim.api.nvim_win_get_buf(winid), winid
  end

  return vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win()
end

local function same_file(left, right)
  if left == "" or right == "" then
    return false
  end

  return vim.fn.fnamemodify(left, ":p") == vim.fn.fnamemodify(right, ":p")
end

local function mergetool_role()
  if vim.env.DOTFILES_MERGETOOL ~= "1" then
    return ""
  end

  local bufnr = statusline_context()
  local name = vim.api.nvim_buf_get_name(bufnr)
  local stage = name:match("^fugitive://.-//([123])")
  if stage then
    return merge_roles[stage] or ""
  end

  if same_file(name, vim.env.DOTFILES_MERGETOOL_MERGED or "") then
    return "MERGE:MERGED"
  end

  return ""
end

return {

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = E.lualine_style,
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { mergetool_role, 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { mergetool_role, 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    }
  }

}
