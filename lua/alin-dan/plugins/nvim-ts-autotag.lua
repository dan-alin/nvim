local M = {}

local fts = {
	"html",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"xml",
}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = fts,
		once = true,
		callback = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
		end,
	})
end

return M
