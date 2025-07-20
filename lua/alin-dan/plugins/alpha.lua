return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local builtin = require("telescope.builtin")
		-- Set header
		dashboard.section.header.val = {
			"                               ",
			"  ██████╗ ████████╗██╗    ██╗  ",
			"  ██╔══██╗╚══██╔══╝██║    ██║  ",
			"  ██████╔╝   ██║   ██║ █╗ ██║  ",
			"  ██╔══██╗   ██║   ██║███╗██║  ",
			"  ██████╔╝   ██║   ╚███╔███╔╝  ",
			"  ╚═════╝    ╚═╝    ╚══╝╚══╝   ",
			"                               ",
		}
		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰱼   Find File", "<cmd>lua require('telescope.builtin').find_files()<CR>"),
			dashboard.button("e", "   File Explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("/", "   Live Grep ", "<cmd>lua require('telescope.builtin').live_grep()<CR>"),
			dashboard.button("g", "󰱼   Find Git Files", "<cmd>lua require('telescope.builtin').git_files()<CR>"),
			dashboard.button("l", "   Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", "   Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", "   Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Add padding to center vertically
		dashboard.config.layout = {
			{ type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
			dashboard.section.header,
			{ type = "padding", val = 5 },
			dashboard.section.buttons,
			{ type = "padding", val = 3 },
			dashboard.section.footer,
		}

		-- Send config to alpha
		alpha.setup(dashboard.config)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
