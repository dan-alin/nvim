local M = {}

-- nvim-treesitter `main`: requires `tree-sitter` on PATH (Mason: `tree-sitter-cli`, or `brew install tree-sitter`).
local ensure_installed = {
	"bash",
	"diff",
	"html",
	"javascript",
	"json",
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
	"go",
	"gomod",
	"gosum",
	"gowork",
	"vue",
}

local function register_languages()
	vim.treesitter.language.register("tsx", "typescriptreact")
	vim.treesitter.language.register("tsx", "javascriptreact")
	vim.treesitter.language.register("svelte", "svelte")
	vim.filetype.add({ extension = { mdx = "mdx" } })
	vim.treesitter.language.register("markdown", "mdx")
end

local function map_textobjects()
	local q = "textobjects"
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
			sel.select_textobject(query, q)
		end)
	end

	local move = require("nvim-treesitter-textobjects.move")
	vim.keymap.set({ "n", "x", "o" }, "]f", function()
		move.goto_next_start("@function.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "]F", function()
		move.goto_next_end("@function.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "]c", function()
		move.goto_next_start("@class.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "]a", function()
		move.goto_next_start("@parameter.inner", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "[f", function()
		move.goto_previous_start("@function.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "[F", function()
		move.goto_previous_end("@function.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "[c", function()
		move.goto_previous_start("@class.outer", q)
	end)
	vim.keymap.set({ "n", "x", "o" }, "[a", function()
		move.goto_previous_start("@parameter.inner", q)
	end)

	local swap = require("nvim-treesitter-textobjects.swap")
	vim.keymap.set("n", "<leader>sn", function()
		swap.swap_next("@parameter.inner")
	end)
	vim.keymap.set("n", "<leader>sp", function()
		swap.swap_previous("@parameter.inner")
	end)
end

--- Wait for `tree-sitter` (e.g. Mason installing `tree-sitter-cli`) then run `install()`.
local function schedule_parser_install()
	local attempts = 0
	local max_attempts = 90 -- ~3 min at 2s interval

	local function step()
		attempts = attempts + 1
		if vim.fn.executable("tree-sitter") == 1 then
			local ok, err = pcall(function()
				require("nvim-treesitter").install(ensure_installed)
			end)
			if not ok then
				vim.notify("nvim-treesitter install: " .. tostring(err), vim.log.levels.WARN)
			end
			return
		end
		if attempts >= max_attempts then
			vim.notify(
				"nvim-treesitter: `tree-sitter` not found on PATH after waiting.\n"
					.. "Install Mason package `tree-sitter-cli` (see :Mason) or `brew install tree-sitter`, then restart.",
				vim.log.levels.WARN
			)
			return
		end
		vim.defer_fn(step, 2000)
	end

	vim.defer_fn(step, 500)
end

function M.setup()
	require("nvim-treesitter").setup({
		install_dir = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "site"),
	})

	schedule_parser_install()

	register_languages()

	local fts = {
		"bash",
		"sh",
		"zsh",
		"diff",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"lua",
		"markdown",
		"toml",
		"vim",
		"yaml",
		"rust",
		"svelte",
		"css",
		"scss",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"vue",
		"liquid",
		"mdx",
	}
	vim.api.nvim_create_autocmd("FileType", {
		pattern = fts,
		callback = function(args)
			pcall(vim.treesitter.start, args.buf)
		end,
	})

	vim.g.no_plugin_maps = true

	require("nvim-treesitter-textobjects").setup({
		select = { lookahead = true },
		move = { set_jumps = true },
	})

	map_textobjects()
end

vim.api.nvim_create_user_command("TSCleanParsers", function()
	local site = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "site")
	for _, name in ipairs({ "parser", "queries" }) do
		local path = vim.fs.joinpath(site, name)
		if vim.fn.isdirectory(path) == 1 then
			vim.fn.delete(path, "rf")
		end
	end
	local lazy_ts = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "nvim-treesitter")
	if vim.fn.isdirectory(lazy_ts) == 1 then
		vim.notify(
			"Removed site/parser and site/queries.\n"
				.. "Stale lazy.nvim treesitter still exists at:\n"
				.. lazy_ts
				.. "\nDelete that folder if you no longer use lazy (e.g. rm -rf).",
			vim.log.levels.WARN
		)
	else
		vim.notify("Removed site/parser and site/queries. Restart Neovim.", vim.log.levels.INFO)
	end
end, {
	desc = "Delete nvim-treesitter parser/query dirs under stdpath('data')/site (fixes bad compiles)",
})

return M
