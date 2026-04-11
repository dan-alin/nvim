local M = {}

function M.setup()
	local gs = require("gitsigns")

	gs.setup({
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		numhl = false,
		linehl = false,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		sign_priority = 6,
		update_debounce = 100,
		max_file_length = 40000,

		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>", { buffer = bufnr, desc = "Preview hunk" })
			vim.keymap.set(
				"n",
				"<leader>gb",
				"<cmd>:Gitsigns toggle_current_line_blame<CR>",
				{ buffer = bufnr, desc = "Blame" }
			)
			vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
			vim.keymap.set("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { buffer = bufnr, desc = "Stage selected hunk" })
			vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
			vim.keymap.set("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { buffer = bufnr, desc = "Reset selected hunk" })
			vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset all changes in buffer" })
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { buffer = bufnr, desc = "Next hunk" })
			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { buffer = bufnr, desc = "Previous hunk" })
		end,
	})
end

return M
