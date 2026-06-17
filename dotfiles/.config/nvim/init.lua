-- disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Compatibility for deprecated tbl_flatten function that is removed in newer versions
if vim.iter then
  vim.tbl_flatten = function(t)
    local result = {}
    local function flatten(list)
      for i = 1, #list do
        local value = list[i]
        if type(value) == 'table' then
          flatten(value)
        elseif value then
          table.insert(result, value)
        end
      end
    end
    flatten(t)
    return result
  end
end

require('config')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
