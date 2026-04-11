local M = {}

function M.setup()
	require("aerial").setup({
		on_attach = function(bufnr)
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
	})
	vim.keymap.set("n", "<leader>st", "<cmd>AerialToggle!<CR>", { desc = "Symbols: toggle outline (Aerial)" })
end

return M
