return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			auto_install = true,
			-- Parsers to install up front; others install on first open of that filetype
			ensure_installed = {
				"bash",
				"diff",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"rust",
				"svelte",
				"css",
				"scss",
				"vue",
			},

			highlight = {
				enable = true,
			},

			query_linter = {
				enable = false,
			},

			playground = {
				enable = false,
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")
			TS.setup(opts)

			-- MDX
			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})
			vim.treesitter.language.register("markdown", "mdx")

			-- textobjects: select
			require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
			local sel = require("nvim-treesitter-textobjects.select")
			local select_maps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					sel.select_textobject(query)
				end)
			end

			-- textobjects: move
			local move = require("nvim-treesitter-textobjects.move")
			local move_maps = {
				{ "]f", "goto_next_start", "@function.outer" },
				{ "]F", "goto_next_end", "@function.outer" },
				{ "]c", "goto_next_start", "@class.outer" },
				{ "]a", "goto_next_start", "@parameter.inner" },
				{ "[f", "goto_previous_start", "@function.outer" },
				{ "[F", "goto_previous_end", "@function.outer" },
				{ "[c", "goto_previous_start", "@class.outer" },
				{ "[a", "goto_previous_start", "@parameter.inner" },
			}
			for _, m in ipairs(move_maps) do
				local key, fn, query = m[1], m[2], m[3]
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move[fn](query)
				end)
			end

			-- textobjects: swap
			local swap = require("nvim-treesitter-textobjects.swap")
			vim.keymap.set("n", "<leader>sn", function()
				swap.swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "<leader>sp", function()
				swap.swap_previous("@parameter.inner")
			end)
		end,
	},
}
