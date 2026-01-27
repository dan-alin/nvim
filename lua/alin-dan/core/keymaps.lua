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
keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd# <CR>", { desc = "Close all buffers except current" }, opts)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" }, opts)

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }, opts) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }, opts) -- decrement

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G, opts")

-- paste without overwriting register
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" }, opts)

-- move lines
keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" }, opts)
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" }, opts)

-- quickfix navigation
keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" }, opts)
keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" }, opts)
