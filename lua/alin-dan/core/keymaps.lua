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
keymap.set(
	"n",
	"<leader>bo",
	"<cmd>%bd|e#|bd# <CR>",
	vim.tbl_extend("force", opts, { desc = "Close all buffers except current" })
)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlights" }))

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", vim.tbl_extend("force", opts, { desc = "Increment number" })) -- increment
keymap.set("n", "-", "<C-x>", vim.tbl_extend("force", opts, { desc = "Decrement number" })) -- decrement

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G", vim.tbl_extend("force", opts, { desc = "Select all" }))

-- paste without overwriting register
keymap.set(
	"x",
	"<leader>p",
	'"_dP',
	vim.tbl_extend("force", opts, { desc = "Paste without overwriting register" })
)

-- move lines
keymap.set("n", "<A-j>", ":m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "Move line down" }))
keymap.set("n", "<A-k>", ":m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "Move line up" }))

-- quickfix navigation
keymap.set("n", "]q", ":cnext<CR>", vim.tbl_extend("force", opts, { desc = "Next quickfix item" }))
keymap.set("n", "[q", ":cprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous quickfix item" }))
