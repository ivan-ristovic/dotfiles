local options = {
    backup = false,                          -- creates a backup file
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    cursorline = false,                      -- highlight the current line
    expandtab = true,                        -- convert tabs to spaces
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    number = true,                           -- set numbered lines
    numberwidth = 4,                         -- set number column width
    pumheight = 10,                          -- pop up menu height
    relativenumber = false,                  -- set relative numbered lines
    scrolloff = 8,
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    showmode = true,
    showtabline = 2,                         -- always show tabs
    sidescrolloff = 8,
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    tabstop = 4,                             -- insert 4 spaces for a tab
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    ttimeoutlen = 100,                       -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = false,                        -- persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    wrap = false,                            -- display lines as one long line
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}
  
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
--vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
  
