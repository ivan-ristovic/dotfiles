-- Status line

local E = require('external.environ')

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
    }
  }

}
