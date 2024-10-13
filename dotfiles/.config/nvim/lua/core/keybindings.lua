local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
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

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Word wrap
keymap("n", "<C-W>", ":set wrap!<CR>", opts)

-- Resize with arrows
keymap("n", "<C-A-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-A-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers/windows
keymap("n", "<C>", "<C-w>h", opts)
keymap("n", "<C-gt>", "<C-w>l", opts)
keymap("n", "<A-Left>", ":bprevious<CR>", opts)
keymap("n", "<A-Right>", ":bnext<CR>", opts)

-- Move text up and down
keymap("n", "<A-Up>", ":m -2<CR>==", opts)
keymap("n", "<A-Down>", ":m +1<CR>==", opts)
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Append next line keeping the curson in place
keymap("n", "J", "mzJ`z", opts)

-- Fix search results in the middle while moving
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- File Tree (NvimTree)
keymap("n", "<leader>t", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>e", ":NvimTreeFocus<cr>", opts)

-- Undo Tree (UndoTree)
keymap('n', '<leader>u', ":UndotreeToggle<cr>", opts)

-- Tab line (Bufferline)
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<cr>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<cr>", opts)

-- Close buffers
keymap("n", "<leader>q", ":enew<bar>bd #<CR>", opts)

-- System clipboard
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)

-- Delete to void
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)

-- (Visual) Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Quickfix list
keymap("n", "<leader>qn", "<cmd>cnext<CR>zz", opts)
keymap("n", "<leader>qp", "<cmd>cprev<CR>zz", opts)

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

