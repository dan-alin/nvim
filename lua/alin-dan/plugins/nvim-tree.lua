local M = {}

function M.setup()
	vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer", silent = true })
	vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", {
		desc = "Toggle file explorer on current file",
		silent = true,
	})

	local nvimtree = require("nvim-tree")

	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	local HEIGHT_RATIO = 0.9
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
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						arrow_closed = "",
						arrow_open = "",
					},
				},
			},
		},
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
end

return M
