return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		-- Skip auto-lint on huge buffers; <leader>l still runs manually
		local max_lines_auto = 20000

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = lint_augroup,
			callback = function(args)
				local buf = args.buf
				if vim.bo[buf].buftype ~= "" or not vim.bo[buf].buflisted then
					return
				end
				if vim.api.nvim_buf_line_count(buf) > max_lines_auto then
					return
				end
				vim.defer_fn(function()
					if not vim.api.nvim_buf_is_valid(buf) then
						return
					end
					vim.api.nvim_buf_call(buf, function()
						lint.try_lint()
					end)
				end, 0)
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
