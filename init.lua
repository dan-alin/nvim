require("alin-dan.core")
require("alin-dan.lazy")

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true, -- Enable underlines for diagnostics
	virtual_text = {
		enabled = true,
		spacing = 4,
		source = "if_many", -- Show source when multiple sources
		prefix = "●", -- Could be '■', '▎', '●', etc.
		severity = { min = vim.diagnostic.severity.HINT }, -- Show all severities
	},
	float = {
		border = "rounded", -- Change to "single", "double", "solid", etc.
		header = "",
		prefix = "",
		focusable = false,
	},
	severity_sort = true, -- Sort diagnostics by severity
	update_in_insert = false, -- Don't update diagnostics while typing
})

-- set the cursoline to be transparent
vim.cmd("highlight CursorLine guibg=NONE ctermbg=NONE")

-- Hide end-of-buffer tildes
vim.opt.fillchars:append({ eob = " " })
