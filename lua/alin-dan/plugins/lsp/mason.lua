local M = {}

function M.setup()
	local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "mason", "bin")
	local sep = vim.fn.has("win32") == 1 and ";" or ":"
	if mason_bin ~= "" and not vim.env.PATH:match(vim.pesc(mason_bin)) then
		vim.env.PATH = mason_bin .. sep .. vim.env.PATH
	end

	require("mason").setup({
		ui = {
			border = "rounded",
			width = 0.9,
			height = 0.9,
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-tool-installer").setup({
		ensure_installed = {
			"tree-sitter-cli",
			"typescript-language-server",
			"svelte-language-server",
			"html-lsp",
			"css-lsp",
			"tailwindcss-language-server",
			"lua-language-server",
			"emmet-ls",
			"rust-analyzer",
			"gopls",
			"vue-language-server",
			"prettier",
			"stylua",
			"gofumpt",
			"goimports",
			"eslint_d",
			"golangci-lint",
		},
	})
end

return M
