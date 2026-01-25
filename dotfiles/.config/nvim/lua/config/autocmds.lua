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

