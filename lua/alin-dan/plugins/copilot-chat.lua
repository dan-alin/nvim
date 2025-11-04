return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	opts = {
		question_header = "## User ",
		answer_header = "## Copilot ",
		error_header = "## Error ",
		window = {
			layout = "float",
			relative = "editor",
			width = 0.8,
			height = 0.8,
			row = 2,
		},
	},
	keys = {
		{ "<leader>cc", ":CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
		{ "<leader>ce", ":CopilotChatExplain<CR>", mode = { "n", "v" }, desc = "Explain code" },
		{ "<leader>ct", ":CopilotChatTests<CR>", mode = { "n", "v" }, desc = "Generate tests" },
		{ "<leader>cr", ":CopilotChatReview<CR>", mode = { "n", "v" }, desc = "Review code" },
		{ "<leader>cf", ":CopilotChatFix<CR>", mode = { "n", "v" }, desc = "Fix code" },
		{
			"<leader>cq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			desc = "Quick chat",
		},
	},
}
