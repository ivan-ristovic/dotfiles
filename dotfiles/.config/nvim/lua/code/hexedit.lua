local status_ok, hex = pcall(require, "hex")
if not status_ok then
  return
end

hex.setup {

  -- cli command used to dump hex data
  dump_cmd = 'xxd -g 1 -u',

  -- cli command used to assemble from hex data
  assemble_cmd = 'xxd -r',
  
  --[[ -- function that runs on BufReadPre to determine if it's binary or not ]]
  --[[ is_file_binary_pre_read = function() ]]
  --[[   -- logic that determines if a buffer contains binary data or not ]]
  --[[   -- must return a bool ]]
  --[[ end, ]]
  --[[]]
  --[[ -- function that runs on BufReadPost to determine if it's binary or not ]]
  --[[ is_file_binary_post_read = function() ]]
  --[[   -- logic that determines if a buffer contains binary data or not ]]
  --[[   -- must return a bool ]]
  --[[ end, ]]
}

