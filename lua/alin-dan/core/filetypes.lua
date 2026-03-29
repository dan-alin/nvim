-- Ensure proper filetype detection and syntax highlighting
vim.filetype.add({
	extension = {
		svelte = "svelte",
	},
})

-- Svelte: run after nvim-treesitter's BufReadPost/BufNewFile lazy load, then attach highlight.
-- vim.schedule runs after all handlers on this event, so TS.setup has finished.
local svelte_au = vim.api.nvim_create_augroup("alin_dan_svelte_treesitter", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = svelte_au,
	pattern = "*.svelte",
	callback = function(args)
		local buf = args.buf
		vim.bo[buf].filetype = "svelte"
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local ok = pcall(vim.treesitter.start, buf)
			if ok then
				return
			end
			if vim.fn.exists(":TSBufEnable") == 2 then
				vim.api.nvim_buf_call(buf, function()
					pcall(vim.cmd, "TSBufEnable highlight")
				end)
			end
		end)
	end,
})

-- Vue: filetype and LSP are handled by built-in detection and mason vue_ls (see lspconfig).
