local M = {}

function M.setup()
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", function()
		builtin.find_files()
	end, { desc = "Find files", silent = true })
	vim.keymap.set("n", "<leader>fr", function()
		builtin.oldfiles()
	end, { desc = "Recent files", silent = true })
	vim.keymap.set("n", "<leader>sr", function()
		builtin.resume()
	end, { desc = "Resume last search", silent = true })
	vim.keymap.set("n", "<leader>/", function()
		builtin.live_grep()
	end, { desc = "Find string (grep)", silent = true })
	vim.keymap.set("n", "<leader>fc", function()
		builtin.grep_string()
	end, { desc = "Find string under cursor", silent = true })
	vim.keymap.set("n", "<leader>fb", function()
		builtin.buffers()
	end, { desc = "Find buffers", silent = true })
	vim.keymap.set("n", "<leader>fh", function()
		builtin.help_tags()
	end, { desc = "Find help", silent = true })
	vim.keymap.set("n", "<leader>fg", function()
		builtin.git_files()
	end, { desc = "Find git files", silent = true })
	vim.keymap.set("n", "<leader>fk", function()
		builtin.keymaps()
	end, { desc = "Find keymaps", silent = true })

	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			path_display = { "smart" },
			file_ignore_patterns = { "node_modules", ".git" },
			preview = {
				treesitter = false,
			},
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
					["<esc>"] = actions.close,
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-q>"] = actions.send_to_qflist,
					["<M-q>"] = actions.send_selected_to_qflist,
				},
			},
		},
	})

	pcall(telescope.load_extension, "fzf")
	pcall(telescope.load_extension, "aerial")
end

return M
