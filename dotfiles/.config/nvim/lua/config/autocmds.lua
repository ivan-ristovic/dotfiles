-- Source:
-- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/config/autocmds.lua
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "User: Highlighted Yank",
    callback = function() vim.hl.on_yank { timeout = 500 } end,
})

---AUTO-SAVE--------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave", "FocusLost" }, {
    desc = "User: Auto-save",
    callback = function(ctx)
        local saveInstantly = ctx.event == "FocusLost" or ctx.event == "BufLeave"
        local bo, b = vim.bo[ctx.buf], vim.b[ctx.buf]
        local bufname = ctx.file
        if bo.buftype ~= "" or bo.ft == "gitcommit" or bo.readonly then return end
        if b.saveQueued and not saveInstantly then return end

        b.saveQueued = true
        vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(ctx.buf) then return end

            vim.api.nvim_buf_call(ctx.buf, function()
                -- saving with explicit name prevents issues when changing `cwd`
                -- `:update!` suppresses "The file has been changed since reading it!!!"
                local vimCmd = ("silent! noautocmd lockmarks update! %q"):format(bufname)
                vim.cmd(vimCmd)
            end)
            b.saveQueued = false
        end, saveInstantly and 0 or 2000)
    end,
})

-- ---AUTO-NOHL & INLINE SEARCH COUNT----------------------------------------------
--  
-- do
--  local config = {
--      scrollbarWidth = 3, -- e.g., from satellite.nvim
--      ignoredPrevNormalModeKeys = { "g", vim.g.mapleader }, -- don't trigger for `gn` or `<leader>n`
--  }
--  local prevKey

--  ---tip: use `vim.opt.shortmess:append("S")` to silence regular search count
--  ---@param mode? "clear"
--  local function searchCountIndicator(mode)
--      local countNs = vim.api.nvim_create_namespace("searchCounter")
--      vim.api.nvim_buf_clear_namespace(0, countNs, 0, -1)
--      if mode == "clear" then return end

--      local row = vim.api.nvim_win_get_cursor(0)[1]
--      local count = vim.fn.searchcount()
--      if vim.tbl_isempty(count) or count.total == 0 then return end
--      local text = (" %d/%d "):format(count.current, count.total)
--      local line = vim.api.nvim_get_current_line():gsub("\t", (" "):rep(vim.bo.shiftwidth))
--      local signcolumn = tonumber(vim.wo.signcolumn:match("%d+") or "0") * 2
--      local viewportWidth = vim.api.nvim_win_get_width(0) - signcolumn - config.scrollbarWidth
--      local lineFull = #line + #text > viewportWidth
--      local margin = { lineFull and (" "):rep(config.scrollbarWidth) or "" }

--      vim.api.nvim_buf_set_extmark(0, countNs, row - 1, 0, {
--          virt_text = { { text, "IncSearch" }, margin },
--          virt_text_pos = lineFull and "right_align" or "eol",
--          priority = 49, -- so it comes in front of `nvim-lsp-endhints`
--      })
--  end

--  -- without the `searchCountIndicator`, this `on_key` simply does `auto-nohl`
--  vim.on_key(function(key, typed)
--      local ignore = vim.tbl_contains(config.ignoredPrevNormalModeKeys, prevKey)
--      prevKey = typed
--      if ignore then return end

--      key = vim.fn.keytrans(key)
--      local isCmdlineSearch = vim.fn.getcmdtype():find("[/?]") ~= nil
--      local isNormalMode = vim.api.nvim_get_mode().mode == "n"
--      local searchStarted = (key == "/" or key == "?") and isNormalMode
--      local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
--      local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
--      if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then return end

--      -- works for RHS, therefore no need to consider remaps
--      local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)

--      if searchCancelled or (not searchMovement and not searchConfirmed) then
--          vim.opt.hlsearch = false
--          searchCountIndicator("clear")
--      elseif searchMovement or searchConfirmed or searchStarted then
--          vim.opt.hlsearch = true
--          vim.defer_fn(searchCountIndicator, 1)
--      end
--  end, vim.api.nvim_create_namespace("autoNohlAndSearchCount"))
--
-- end

