-- Coding plugins

return {

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = '┆' },
      scope = { enabled = false },
    },
  },

  -- Brackets/Parens pairing and autoindenting
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    command = function ()
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end,
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    }
  },

  -- Smart commenting
  {
    'numToStr/Comment.nvim',
    opts = {
      pre_hook = function(ctx)
        local U = require "Comment.utils"
        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end
        return require("ts_context_commentstring.internal").calculate_commentstring {
          key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
          location = location,
        }
      end,
    }
  },

  -- Split/Join blocks of code
--  {
--    'Wansmer/treesj',
--    dependencies = { 'nvim-treesitter/nvim-treesitter' },
--    opts = {
--
--      -- Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
--      use_default_keymaps = false,
--
--      -- Node with syntax error will not be formatted
--      check_syntax_error = true,
--
--      -- If line after join will be longer than max value, node will not be formatted
--      max_join_length = 120,
--
--      ---Cursor behavior:
--      ---hold - cursor follows the node/place on which it was called
--      ---start - cursor jumps to the first symbol of the node being formatted
--      ---end - cursor jumps to the last symbol of the node being formatted
--      cursor_behavior = 'hold',
--
--      -- Notify about possible problems or not
--      notify = true,
--
--      -- Use `dot` for repeat action
--      dot_repeat = true,
--
--      -- Callback for treesj error handler. func (err_text, level, ...other_text)
--      on_error = nil,
--
--      -- Presets for languages
--      -- langs = {}, -- See the default presets in lua/treesj/langs
--    },
--    keys = {
--      { "<leader>z", require('treesj').toggle, desc = "Toggle multiline object split" },
--      {
--        "<leader>Z",
--        function()
--          require('treesj').toggle({ split = { recursive = true } })
--        end,
--        desc = "Toggle multiline object split"
--      },
--    }
--  },

}
