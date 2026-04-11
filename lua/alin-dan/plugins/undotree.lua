local M = {}

function M.setup()
	require("undotree").setup({})
	vim.keymap.set("n", "<leader>u", function()
		require("undotree").toggle()
	end, { desc = "Toggle undotree", silent = true })
end

return M
