return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()

		-- Basic keymaps
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		-- Add current file to harpoon
		keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, vim.tbl_extend("force", opts, { desc = "Add file to harpoon" }))

		-- Toggle quick menu (changed from <leader>e to avoid nvim-tree conflict)
		keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, vim.tbl_extend("force", opts, { desc = "Toggle harpoon menu" }))

		-- Navigate to files (1-4)
		keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, vim.tbl_extend("force", opts, { desc = "Harpoon file 1" }))
		keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, vim.tbl_extend("force", opts, { desc = "Harpoon file 2" }))
		keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, vim.tbl_extend("force", opts, { desc = "Harpoon file 3" }))
		keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, vim.tbl_extend("force", opts, { desc = "Harpoon file 4" }))

		-- Navigate back and forth through the list
		keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, vim.tbl_extend("force", opts, { desc = "Previous harpoon file" }))
		keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end, vim.tbl_extend("force", opts, { desc = "Next harpoon file" }))

		-- Additional useful keymaps
		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, vim.tbl_extend("force", opts, { desc = "Add file to harpoon" }))
		keymap.set("n", "<leader>hr", function()
			harpoon:list():remove()
		end, vim.tbl_extend("force", opts, { desc = "Remove file from harpoon" }))
		keymap.set("n", "<leader>hc", function()
			harpoon:list():clear()
		end, vim.tbl_extend("force", opts, { desc = "Clear harpoon list" }))
	end,
}
