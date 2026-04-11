local M = {}

function M.setup()
	vim.o.timeout = true
	vim.o.timeoutlen = 500

	require("which-key").setup({
		delay = 500,
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>la", desc = "Attached clients (float)" },
			{ "<leader>s", group = "Search/Symbols" },
			{ "<leader>b", group = "Buffers" },

			{ "<leader>ff", desc = "Files" },
			{ "<leader>fr", desc = "Recent files" },
			{ "<leader>fb", desc = "Buffers" },
			{ "<leader>fg", desc = "Git files" },
			{ "<leader>fh", desc = "Help tags" },
			{ "<leader>fk", desc = "Keymaps" },

			{ "<leader>sr", desc = "Resume last search" },
			{ "<leader>ss", desc = "Document symbols (Aerial)" },
			{ "<leader>sS", desc = "Workspace symbols" },
			{ "<leader>st", desc = "Toggle outline (Aerial)" },
			{ "<leader>/", desc = "Find string (grep)" },

			{ "<leader>gs", desc = "Stage hunk" },
			{ "<leader>gr", desc = "Reset hunk" },
			{ "<leader>gR", desc = "Reset entire file" },
			{ "<leader>gp", desc = "Preview hunk" },
			{ "<leader>gb", desc = "Blame line" },
		},
	})
end

return M
