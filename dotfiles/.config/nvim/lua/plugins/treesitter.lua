-- Treesitter (syntax highlighting AST+API)

local ensure_installed = {
  "bash",
  "c",
  "c_sharp",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "git_config",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "java",
  "javascript",
  "json",
  "jsonnet",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

local highlight_disabled = {
  css = true,
}

local indent_disabled = {
  css = true,
  python = true,
}

local installed_parsers = {}
for _, parser in ipairs(ensure_installed) do
  installed_parsers[parser] = true
end

local parser_aliases = {
  bash = { "sh", "zsh" },
  c_sharp = "cs",
  git_config = "gitconfig",
  tsx = "typescriptreact",
}

local warned_missing_cli = false

local function warn_lazy_sync()
  vim.schedule(function()
    vim.notify("nvim-treesitter API mismatch; run :Lazy sync", vim.log.levels.WARN)
  end)
end

local function has_tree_sitter_cli()
  return vim.fn.executable("tree-sitter") == 1
end

local function warn_missing_cli()
  if warned_missing_cli then
    return
  end

  warned_missing_cli = true
  vim.schedule(function()
    vim.notify("tree-sitter CLI missing; install tree-sitter-cli, then run :TSUpdate", vim.log.levels.WARN)
  end)
end

local function parser_for_filetype(ft)
  local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
  if ok and lang then
    return lang
  end
  return ft
end

local function enable_treesitter(buf)
  local ft = vim.bo[buf].filetype
  if highlight_disabled[ft] then
    return
  end

  local lang = parser_for_filetype(ft)
  if not installed_parsers[lang] then
    return
  end

  pcall(vim.treesitter.start, buf, lang)
end

local function enable_treesitter_indent(buf)
  local ft = vim.bo[buf].filetype
  if indent_disabled[ft] then
    return
  end

  local lang = parser_for_filetype(ft)
  if not installed_parsers[lang] then
    return
  end

  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,

    build = function()
      if not has_tree_sitter_cli() then
        warn_missing_cli()
        return
      end

      vim.cmd("TSUpdate")
    end,

    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },

    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()

      if type(ts.install) ~= "function" then
        warn_lazy_sync()
        return
      end

      if has_tree_sitter_cli() then
        ts.install(ensure_installed)
      else
        warn_missing_cli()
      end

      for lang, filetypes in pairs(parser_aliases) do
        pcall(vim.treesitter.language.register, lang, filetypes)
      end

      local group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          enable_treesitter(args.buf)
          enable_treesitter_indent(args.buf)
        end,
      })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local ok_textobjects, textobjects = pcall(require, "nvim-treesitter-textobjects")
      local ok_select, select = pcall(require, "nvim-treesitter-textobjects.select")
      local ok_move, move = pcall(require, "nvim-treesitter-textobjects.move")

      if not ok_textobjects or not ok_select or not ok_move then
        warn_lazy_sync()
        return
      end

      textobjects.setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      vim.keymap.set({ "x", "o" }, "aa", function()
        select.select_textobject("@parameter.outer", "textobjects")
      end, { desc = "Select outer parameter" })

      vim.keymap.set({ "x", "o" }, "ia", function()
        select.select_textobject("@parameter.inner", "textobjects")
      end, { desc = "Select inner parameter" })

      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select outer function" })

      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inner function" })

      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select outer class" })

      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inner class" })

      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })

      vim.keymap.set({ "n", "x", "o" }, "]]", function()
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start" })

      vim.keymap.set({ "n", "x", "o" }, "]M", function()
        move.goto_next_end("@function.outer", "textobjects")
      end, { desc = "Next function end" })

      vim.keymap.set({ "n", "x", "o" }, "][", function()
        move.goto_next_end("@class.outer", "textobjects")
      end, { desc = "Next class end" })

      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })

      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start" })

      vim.keymap.set({ "n", "x", "o" }, "[M", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end, { desc = "Previous function end" })

      vim.keymap.set({ "n", "x", "o" }, "[]", function()
        move.goto_previous_end("@class.outer", "textobjects")
      end, { desc = "Previous class end" })
    end
  },


  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 1,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,
    }
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true
      }
    },
  },

}

