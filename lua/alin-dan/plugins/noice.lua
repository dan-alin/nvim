local M = {}

function M.setup()
	require("noice").setup({
		lsp = {
			-- Quiet: use statusline ✓ + `:LspAttached` instead of progress/message toasts.
			progress = {
				enabled = false,
			},
			message = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = {
					skip = true,
				},
			},
		},
		presets = {
			lsp_doc_border = true,
		},
	})
end

return M
