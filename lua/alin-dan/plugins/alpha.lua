return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	keys = {
		{ "<leader>A", "<cmd>Alpha<CR>", desc = "Open Alpha" },
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"                               ",
			-- "  ██████╗ ████████╗██╗    ██╗  ",
			-- "  ██╔══██╗╚══██╔══╝██║    ██║  ",
			-- "  ██████╔╝   ██║   ██║ █╗ ██║  ",
			-- "  ██╔══██╗   ██║   ██║███╗██║  ",
			-- "  ██████╔╝   ██║   ╚███╔███╔╝  ",
			-- "  ╚═════╝    ╚═╝    ╚══╝╚══╝   ",
			"                               ",
		}
		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰱼   Find File", "<cmd>lua require('telescope.builtin').find_files()<CR>"),
			dashboard.button("e", "   File Explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("/", "   Live Grep ", "<cmd>lua require('telescope.builtin').live_grep()<CR>"),
			dashboard.button("g", "󰱼   Find Git Files", "<cmd>lua require('telescope.builtin').git_files()<CR>"),
			dashboard.button("m", "   Mason", "<cmd>Mason<CR>"),
			dashboard.button("l", "   Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("q", "   Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Simple layout without excessive padding to prevent scrolling
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Send config to alpha
		alpha.setup(dashboard.config)

		-- Create autocommand group for alpha buffer settings
		local alpha_group = vim.api.nvim_create_augroup("alpha_buffer_settings", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			group = alpha_group,
			callback = function()
				local opts = { silent = true, buffer = true }
				-- Disable all scrolling
				vim.keymap.set("n", "<ScrollWheelUp>", "<Nop>", opts)
				vim.keymap.set("n", "<ScrollWheelDown>", "<Nop>", opts)
				vim.keymap.set("n", "<C-u>", "<Nop>", opts)
				vim.keymap.set("n", "<C-d>", "<Nop>", opts)
				vim.keymap.set("n", "<C-b>", "<Nop>", opts)
				vim.keymap.set("n", "<C-f>", "<Nop>", opts)
				vim.keymap.set("n", "<PageUp>", "<Nop>", opts)
				vim.keymap.set("n", "<PageDown>", "<Nop>", opts)
				vim.keymap.set("n", "gg", "<Nop>", opts)
				vim.keymap.set("n", "G", "<Nop>", opts)

				-- Set buffer options
				vim.opt_local.foldenable = false
				vim.opt_local.modifiable = false
				vim.opt_local.swapfile = false
				vim.opt_local.bufhidden = "wipe"
				vim.opt_local.buftype = "nofile"
				vim.opt_local.cursorline = false
				vim.opt_local.list = false
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.scrollbind = false
				vim.opt_local.signcolumn = "no"
				vim.opt_local.wrap = false
				vim.opt_local.scrolloff = 0
			end,
		})
	end,
}
