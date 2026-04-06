return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"typescript-language-server",
				"svelte-language-server",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"lua-language-server",
				"emmet-ls",
				"rust-analyzer",
				"gopls",
				-- Formatters
				"prettier",
				"stylua",
				"gofumpt",
				"goimports",
				-- Linters
				"eslint_d",
				"golangci-lint",
			},
		})
	end,
}
