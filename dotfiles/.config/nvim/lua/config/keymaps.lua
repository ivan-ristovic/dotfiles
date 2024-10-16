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

-- Word wrap
U.keymap("n", "<C-W>", ":set wrap!<CR>", "Word wrap")
U.keymap_expr('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", "Wrap-aware navigation")
U.keymap_expr('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", "Wrap-aware navigation")

-- Resize with arrows
U.keymap("n", "<C-A-Up>", ":resize -2<CR>", "Resize")
U.keymap("n", "<C-A-Down>", ":resize +2<CR>", "Resize")
U.keymap("n", "<C-A-Left>", ":vertical resize -2<CR>", "Resize")
U.keymap("n", "<C-A-Right>", ":vertical resize +2<CR>", "Resize")

-- Navigate buffers/windows
U.keymap("n", "<C>", "<C-w>h")
U.keymap("n", "<C-gt>", "<C-w>l")
U.keymap("n", "<A-Left>", ":bprevious<CR>")
U.keymap("n", "<A-Right>", ":bnext<CR>")

-- Move selection
U.keymap("n", "<A-Up>", ":m -2<CR>==", "Move selection up")
U.keymap("n", "<A-Down>", ":m +1<CR>==", "Move selection down")
U.keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", "Move selection up")
U.keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", "Move selection up")
U.keymap("v", "p", '"_dP', "Replace selection")
U.keymap("x", "K", ":move '<-2<CR>gv-gv", "Move selection up")
U.keymap("x", "J", ":move '>+1<CR>gv-gv", "Move selection down")
U.keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move selection up")
U.keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move selection down")

-- Append next line keeping the curson in place
U.keymap("n", "J", "mzJ`z", "Append next line")

-- Fix search results in the middle while moving
U.keymap("n", "n", "nzzzv")
U.keymap("n", "N", "Nzzzv")

-- Tab line (Bufferline)
U.keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<cr>")
U.keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<cr>")
U.keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<cr>")
U.keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<cr>")
U.keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<cr>")
U.keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<cr>")
U.keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<cr>")
U.keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<cr>")
U.keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<cr>")

-- Close buffers
U.keymap("n", "<leader>q", ":enew<bar>bd #<CR>")

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
U.keymap("n", "<leader>qn", "<cmd>cnext<CR>zz")
U.keymap("n", "<leader>qp", "<cmd>cprev<CR>zz")

-- Better terminal navigation
-- U.keymap("t", "<C-h>", "<C-\\><C-N><C-w>h")
-- U.keymap("t", "<C-j>", "<C-\\><C-N><C-w>j")
-- U.keymap("t", "<C-k>", "<C-\\><C-N><C-w>k")
-- U.keymap("t", "<C-l>", "<C-\\><C-N><C-w>l")

