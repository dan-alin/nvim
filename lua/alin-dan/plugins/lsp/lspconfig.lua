return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- import mason-lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				-- gd: jump to single definition; <leader>gd: browse/pick (Telescope)
				opts.desc = "Definition: jump (not Telescope)"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Definition: Telescope (pick location)"
				keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP (built-in :LspRestart)"
				keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

				opts.desc = "Show document symbols (Telescope)"
				keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", opts)

				opts.desc = "Show workspace symbols (Telescope)"
				keymap.set("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Set default position encoding to help with warnings
		capabilities.offsetEncoding = { "utf-16" }

		-- Increase LSP timeout for better reliability
		vim.lsp.set_log_level("WARN") -- Reduce log verbosity

		-- Setup mason-lspconfig with handlers
		mason_lspconfig.setup({
			-- Mason installs these on sync; add e.g. graphql / prismals here if you use them
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"emmet_ls",
				"rust_analyzer",
				"vue_ls",
			},
			automatic_installation = true,
			handlers = {
				-- default handler for installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- TypeScript server with Vue support
				["ts_ls"] = function()
					local mason_registry = require("mason-registry")
					local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
						.. "/node_modules/@vue/language-server"

					lspconfig["ts_ls"].setup({
						capabilities = capabilities,
						init_options = {
							plugins = {
								{
									name = "@vue/typescript-plugin",
									location = vue_language_server_path,
									languages = { "vue" },
								},
							},
						},
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
					})
				end,

				-- Tailwind CSS with custom settings
				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"typescript",
							"vue",
							"svelte",
							"javascriptreact",
							"typescriptreact",
						},
						settings = {
							tailwindCSS = {
								classAttributes = { "class", "className", "classList", "ngClass" },
								lint = {
									cssConflict = "warning",
									invalidApply = "error",
									invalidConfigPath = "error",
									invalidScreen = "error",
									invalidTailwindDirective = "error",
									invalidVariant = "error",
									recommendedVariantOrder = "warning",
								},
								validate = true,
								experimental = {
									classRegex = {
										"return\\s+['\"]([^'\"]*)['\"]|return\\s*\\{[^}]*['\"]([^'\"]*)['\"]|return\\s*`([^`]*)`",
										":class\\s*=\\s*['\"]([^'\"]*)['\"]|class\\s*=\\s*['\"]([^'\"]*)['\"]|\\[class\\]\\s*=\\s*['\"]([^'\"]*)['\"]|\\[class\\]\\s*=\\s*`([^`]*)`",
										"clsx\\(([^)]*)\\)|classnames\\(([^)]*)\\)|cn\\(([^)]*)\\)",
										"`([^`]*)`|\\$\\{[^}]*['\"]([^'\"]*)['\"]|['\"]([^'\"]*)['\"](?=\\s*(?:;|\\)|,|$))",
										"['\"]([^'\"]*)['\"]\\s*(?::|,)|\\{[^}]*['\"]([^'\"]*)['\"]|\\[[^\\]]*['\"]([^'\"]*)['\"]|([a-zA-Z0-9\\-_]+)(?=\\s*:)",
									},
								},
							},
						},
					})
				end,

				-- Rust analyzer with clippy
				["rust_analyzer"] = function()
					lspconfig["rust_analyzer"].setup({
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								check = {
									command = "clippy",
								},
							},
						},
					})
				end,

				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,

				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
						init_options = {
							html = {
								options = {
									-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
									["bem.enabled"] = true,
								},
							},
						},
					})
				end,

				["vue_ls"] = function()
					-- Vue language server works with ts_ls in hybrid mode
					-- No additional config needed - just ensure ts_ls is also running
					lspconfig["vue_ls"].setup({
						capabilities = capabilities,
						filetypes = { "vue" },
					})
				end,
			},
		})
	end,
}
