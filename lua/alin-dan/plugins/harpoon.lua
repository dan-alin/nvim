return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file to harpoon",
		},
		{
			"<leader>hm",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle harpoon menu",
		},
		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Harpoon file 1",
		},
		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Harpoon file 2",
		},
		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Harpoon file 3",
		},
		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Harpoon file 4",
		},
		{
			"<C-S-P>",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Previous harpoon file",
		},
		{
			"<C-S-N>",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Next harpoon file",
		},
		{
			"<leader>ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file to harpoon",
		},
		{
			"<leader>hr",
			function()
				require("harpoon"):list():remove()
			end,
			desc = "Remove file from harpoon",
		},
		{
			"<leader>hc",
			function()
				require("harpoon"):list():clear()
			end,
			desc = "Clear harpoon list",
		},
	},
}
