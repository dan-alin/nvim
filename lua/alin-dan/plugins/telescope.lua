return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = { "node_modules", ".git" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close, -- close pressing esc
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_to_qflist, -- send all to quickfix (without opening)
						["<M-q>"] = actions.send_selected_to_qflist, -- send selected to quickfix (without opening)
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>f", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>F", builtin.grep_string, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>b", builtin.buffers, { desc = "Open buffers" })
		keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Open help tags" })
		keymap.set("n", "<leader>g", builtin.git_files, { desc = "Open git files" })
		keymap.set("n", "<leader>tq", builtin.quickfix, { desc = "Telescope quickfix" })
		keymap.set("n", "<leader>A", "<cmd>Alpha<CR>", { desc = "Open Alpha" })
	end,
}
