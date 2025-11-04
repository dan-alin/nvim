return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	config = function()
		-- Suppress deprecation warnings temporarily while plugins update
		local notify_once = vim.notify_once
		vim.notify_once = function(msg, level, opts)
			if type(msg) == "string" and msg:match("jump_to_location.*deprecated") then
				return -- Suppress jump_to_location deprecation warnings
			end
			return notify_once(msg, level, opts)
		end

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

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

				-- Alternative Telescope mapping
				opts.desc = "Show LSP definitions (Telescope)"
				keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions via telescope

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

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Set default position encoding to help with warnings
		capabilities.offsetEncoding = { "utf-16" }

		-- Increase LSP timeout for better reliability
		vim.lsp.set_log_level("WARN") -- Reduce log verbosity

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- Configure diagnostic signs using the modern API
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
		})

		-- Setup mason-lspconfig with handlers
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"prismals",
				"rust_analyzer",
				"angularls",
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

				["angularls"] = function()
					lspconfig["angularls"].setup({
						capabilities = capabilities,
						-- Include htmlangular for Angular component templates
						filetypes = { "typescript", "html", "htmlangular", "typescriptreact" },
						root_dir = function(fname)
							local root = lspconfig.util.root_pattern("angular.json", "project.json", "nx.json")(fname)
							if not root then
								return nil
							end

							local has_lang_service = vim.fn.filereadable(
								root .. "/node_modules/@angular/language-service/package.json"
							) == 1
							if not has_lang_service then
								vim.notify(
									"Angular LSP: @angular/language-service not found in "
										.. root
										.. ". Install it with: npm install --save-dev @angular/language-service",
									vim.log.levels.WARN
								)
								return nil
							end

							return root
						end,
						settings = {
							angular = {
								enableTracing = false,
								log = "off",
								strictTemplates = true,
							},
						},
						on_attach = function(client, bufnr)
							-- Angular 20 specific optimizations
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
					})
				end,
			},
		})
	end,
}
