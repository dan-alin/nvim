return {
	"nvim-tree/nvim-tree.lua",
	cmd = {
		"NvimTreeToggle",
		"NvimTreeFindFileToggle",
		"NvimTreeFocus",
		"NvimTreeClose",
	},
	keys = {
		{ "<leader>E", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
		{
			"<leader>e",
			"<cmd>NvimTreeFindFileToggle<CR>",
			desc = "Toggle file explorer on current file",
		},
	},
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local HEIGHT_RATIO = 0.9 -- You can change this
		local WIDTH_RATIO = 0.9

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")
			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "<Esc>", api.tree.close, {
				buffer = bufnr,
				silent = true,
				noremap = true,
				nowait = true,
				desc = "nvim-tree: Close",
			})
		end

		nvimtree.setup({
			on_attach = on_attach,
			disable_netrw = true,
			hijack_netrw = true,
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			view = {
				relativenumber = true,
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
						return {
							border = "rounded",
							relative = "editor",
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			filters = {
				custom = { ".DS_Store", "Thumbs.db", "desktop.ini" },
			},
			git = {
				ignore = true,
			},
		})
	end,
}
