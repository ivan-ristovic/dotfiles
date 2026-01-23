local U = require('utils')

--Remap space as leader key
U.keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

U.keymap("n", "<C-q>", ":bd<CR>")

-- Easier :
U.keymap("n", ";", ":")

-- Faster exit
U.keymap("n", "Q", ":qa!<CR>")

-- Better redo
U.keymap("n", "U", "<C-r>", "Redo")

-- Remap increment to C-I
U.keymap("n", "<C-I>", "<C-A>")

-- Clear highlights after search
U.keymap("n", "<C-l>", ":nohlsearch<cr>", "Clear highlights")

-- Shell-like moving to begin/end of line
U.keymap("n", "<C-a>", "^", "Go to beginning of line")
U.keymap("n", "<C-e>", "$", "Go to end of line")

-- Jump motions
U.keymap("n", "<C-A-Left>", "<C-O>", "[G]o to [P]revious Cursor Position")
U.keymap("n", "<C-A-Right>", "<C-I>", "[G]o to [N]ext Cursor Position")
U.keymap("n", "gp", "<C-O>", "[G]o to [P]revious Cursor Position")
U.keymap("n", "gn", "<C-I>", "[G]o to [N]ext Cursor Position")

-- Word wrap
U.keymap("n", "<A-z>", ":set wrap!<cr>", "Word wrap")
U.keymap_expr('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", "Wrap-aware navigation")
U.keymap_expr('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", "Wrap-aware navigation")

-- Resize with arrows
--[[ U.keymap("n", "<C-A-Up>", ":resize -2<cr>", "Resize") ]]
--[[ U.keymap("n", "<C-A-Down>", ":resize +2<cr>", "Resize") ]]
--[[ U.keymap("n", "<C-A-Left>", ":vertical resize -2<cr>", "Resize") ]]
--[[ U.keymap("n", "<C-A-Right>", ":vertical resize +2<cr>", "Resize") ]]

-- Navigate buffers/windows
-- Note: <C-PgUp>/gT and <C-PgDown>/gt are default tabpage navigation keymaps!
U.keymap("n", "<C-A-q>", ":tabclose!<cr>")
U.keymap("n", "<C-A-c>", ":tabedit<cr>")
U.keymap("n", "<A-Left>", ":bprevious<cr>")
U.keymap("n", "<A-Right>", ":bnext<cr>")

-- Move selection up/down
U.keymap("n", "<A-Up>", ":m -2<cr>==", "Move selection up")
U.keymap("n", "<A-Down>", ":m +1<cr>==", "Move selection down")
U.keymap("v", "<A-Up>", ":m '<-2<cr>gv=gv", "Move selection up")
U.keymap("v", "<A-Down>", ":m '>+1<cr>gv=gv", "Move selection up")
U.keymap("v", "p", '"_dP', "Replace selection")
U.keymap("x", "K", ":move '<-2<cr>gv-gv", "Move selection up")
U.keymap("x", "J", ":move '>+1<cr>gv-gv", "Move selection down")
U.keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", "Move selection up")
U.keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", "Move selection down")

-- Append next line keeping the cursor in place
U.keymap("n", "J", "mzJ`z", "Append next line")

-- Fix search results in the middle while moving
U.keymap("n", "n", "nzzzv")
U.keymap("n", "N", "Nzzzv")

-- System clipboard
U.keymap("n", "<leader>y", '"+y')
U.keymap("v", "<leader>y", '"+y')

-- Delete to void
U.keymap("n", "<leader>d", '"_d')
U.keymap("v", "<leader>d", '"_d')

-- (Visual) Stay in indent mode
U.keymap("v", "<", "<gv")
U.keymap("v", ">", ">gv")

-- Quickfix list
U.keymap("n", "<leader>ln", "<cmd>cnext<cr>zz")
U.keymap("n", "<leader>lp", "<cmd>cprev<cr>zz")

-- Better terminal navigation
-- U.keymap("t", "<C-h>", "<C-\\><C-N><C-w>h")
-- U.keymap("t", "<C-j>", "<C-\\><C-N><C-w>j")
-- U.keymap("t", "<C-k>", "<C-\\><C-N><C-w>k")
-- U.keymap("t", "<C-l>", "<C-\\><C-N><C-w>l")

