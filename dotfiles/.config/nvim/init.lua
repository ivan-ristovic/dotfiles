require "conf.options"
require "conf.keybindings"

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
end

require "conf.plugins"

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

require "conf.statusline"
require "conf.colorscheme"
require "conf.finder"
require "conf.filetree"
require "conf.tabline"

require "code.treesitter"
require "code.autopairs"
require "code.gitsigns"
require "code.comments"

require "lsp.cmp"
require "lsp.lsp"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
