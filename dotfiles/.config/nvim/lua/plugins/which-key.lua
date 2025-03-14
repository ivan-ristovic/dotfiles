-- Key mapping helper popup

return {

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      preset = 'helix',
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Show keymap hints",
      },
    },
  }

}
