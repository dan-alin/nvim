vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- save file
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts)

-- quit file
keymap.set("n", "<leader>q", "<cmd>q<CR>", opts)

-- esc insert mode
keymap.set("i", "jk", "<ESC>", opts)

-- goto end of line
keymap.set("n", "ge", "$", opts)

-- goto start of line
keymap.set("n", "gs", "^", opts)

-- move between buffers
keymap.set("n", "<TAB>", "<cmd>bn<CR>", opts)
keymap.set("n", "<S-TAB>", "<cmd>bp<CR>", opts)
keymap.set("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>", opts)

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- move lines
keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })

keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" })
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

keymap.set("n", "<leader>qt", function()
	if vim.fn.getqflist({ winid = 0 }).winid > 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Toggle quickfix" })
