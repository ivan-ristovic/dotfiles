-- Appearance and general functionality

local E = require('external.environ')

return {

  -- VSCode-like color scheme 
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      require('vscode').load()
    end,
    opts = {
      -- Alternatively set style in setup
      style = E.vscode_theme_style,

      -- Enable transparent background
      transparent = false,

      -- Enable italic comment
      italic_comments = false,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      -- color_overrides = {
      --     vscLineNumber = '#FFFFFF',
      -- },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      -- group_overrides = {
      --     -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
    --     Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    -- }
    }
  },

  -- Absolute/Relative number autotoggle
  {
    'sitiom/nvim-numbertoggle'
  },

  -- Multi-cursors
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = {
        ["Add Cursor Up"] = "<C-A-Up>",
        ["Add Cursor Down"] = "<C-A-Down>",
      }
    end,
  },

  -- Fidget with status updates
  {
    'j-hui/fidget.nvim',
    opts = {
      integration = {
        ["nvim-tree"] = {
          enable = true,
        },
      }
    }
  },

}
