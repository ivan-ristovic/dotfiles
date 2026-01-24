-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/after/ftplugin/
--------------------------------------------------------------------------------

local bkeymap = require("config.utils").bufKeymap

-- `gO` opens the heading-selection man pages
bkeymap("n", "gs", "gO", { remap = true })
