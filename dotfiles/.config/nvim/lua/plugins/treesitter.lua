-- Treesitter (syntax highlighting AST+API)

return {

  {
    "nvim-treesitter/nvim-treesitter",

    build = function()
      pcall(require("nvim-treesitter.install").update({
        with_sync = true,
      }))
    end,

    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },

    config = function()

      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        autopairs = {
          enable = true
        },
        highlight = {
          enable = true,
          disable = { "css" }
        },
        indent = {
          enable = true,
          disable = { "python", "css" },
        },
        incremental_selection = {
          enable = false,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })

    end    -- end config
  }

}
