return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		--local trouble = require("trouble")
		--local trouble_telescope = require("trouble.providers.telescope")

		-- or create your custom action
		--local custom_actions = transform_mod({
		--open_trouble_qflist = function()
		--trouble.toggle("quickfix")
		--end,
		--})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						--["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						--	["<C-t>"] = trouble_telescope.smart_open_with_trouble,
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
		keymap.set("n", "<leader>A", "<cmd>Alpha<CR>", { desc = "Open Alpha" })
	end,
}
