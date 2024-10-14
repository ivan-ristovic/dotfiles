local status_ok, treesj = pcall(require, "treesj")
if not status_ok then
  return
end

treesj.setup {

  -- Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value, node will not be formatted
  max_join_length = 120,

  ---Cursor behavior:
  ---hold - cursor follows the node/place on which it was called
  ---start - cursor jumps to the first symbol of the node being formatted
  ---end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,

  -- Use `dot` for repeat action
  dot_repeat = true,

  -- Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,

  -- Presets for languages
  -- langs = {}, -- See the default presets in lua/treesj/langs
}

