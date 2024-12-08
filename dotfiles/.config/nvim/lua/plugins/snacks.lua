return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
        size = 2 * 1024 * 1024,
      },
      gitbrowse = {
        enabled = true,
      },
      lazygit = {
        enabled = true,
      },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact" -- compact|fancy|minimal
      },
      quickfile = {
        enabled = true,
      },
    },
    keys = {
      { "<leader>N",  function() Snacks.notifier.show_history() end, desc = "[N]otification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "[B]uffer [D]elete" },
      { "<leader>gW", function() Snacks.gitbrowse() end, desc = "[G]it [W]eb Browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazy[G]it Current [F]ile History" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazy[G]it [L]og (cwd)" },
      { "<leader>dN", function() Snacks.notifier.hide() end, desc = "[D]ismiss All [N]otifications" },
    },
  }
}
