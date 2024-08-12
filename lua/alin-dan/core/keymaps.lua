vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }


keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- move lines
keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
