local M = {}

function M.setup()
	local transparent = true

	require("tokyonight").setup({
		style = "night",
		transparent = transparent,
		styles = {
			sidebars = transparent and "transparent" or "dark",
			floats = transparent and "transparent" or "dark",
		},
	})

	vim.cmd.colorscheme("tokyonight")
end

return M
