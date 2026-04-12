local M = {}

function M.setup()
	local notify = require("notify")
	notify.setup({
		merge_duplicates = true,
		background_colour = "#000000",
		fps = 30,
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "✎",
			WARN = "",
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "fade_in_slide_out",
		timeout = 3000,
		-- Stack upward from the bottom (closer to bottom-right with default layout).
		top_down = false,
		border = "rounded",
	})
	vim.notify = notify
end

return M
