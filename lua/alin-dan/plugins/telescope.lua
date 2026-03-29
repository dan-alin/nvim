local fzf_build = vim.fn.has("win32") == 1
		and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
	or "make"

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{
			"<leader>f",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Fuzzy find files in cwd",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Find string in cwd",
		},
		{
			"<leader>F",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Find string under cursor in cwd",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Open buffers",
		},
		{
			"<leader>h",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Open help tags",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Open git files",
		},
		{
			"<leader>tq",
			function()
				require("telescope.builtin").quickfix()
			end,
			desc = "Telescope quickfix",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = fzf_build },
		"nvim-tree/nvim-web-devicons",
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

		pcall(telescope.load_extension, "fzf")
	end,
}
