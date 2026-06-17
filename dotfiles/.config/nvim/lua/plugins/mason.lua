local mason_tools = {
  "tree-sitter-cli",
  "misspell",
  "shellcheck",
  "shfmt",
  "editorconfig-checker",
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      local mason = require("mason")
      if not mason.has_setup then
        mason.setup(opts)
      end
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
    opts = {
      ensure_installed = mason_tools,
      run_on_start = true,
      start_delay = 3000,
      auto_update = false,
      integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
      },
    },
  },
}
