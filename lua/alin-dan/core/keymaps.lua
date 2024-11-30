vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- save file
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts)

-- quit file
keymap.set("n", "<leader>q", "<cmd>q<CR>", opts)

-- esc insert mode
keymap.set("i", "jk", "<ESC>", opts)

-- delete buffer
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", opts)

-- goto end of line
keymap.set("n", "ge", "$", opts)

-- goto start of line
keymap.set("n", "gs", "^", opts)



-- move between buffers
keymap.set("n", "<TAB>", "<cmd>bn<CR>", opts)
keymap.set("n", "<S-TAB>", "<cmd>bp<CR>", opts)


keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- move lines
keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
