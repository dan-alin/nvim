-- Ensure proper filetype detection and syntax highlighting
vim.filetype.add({
	extension = {
		svelte = "svelte",
	},
})

-- Ensure Treesitter highlighting is enabled for Svelte files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.svelte",
	callback = function()
		vim.bo.filetype = "svelte"
		-- Force enable Treesitter highlighting for this buffer
		if vim.fn.exists(":TSBufEnable") == 2 then
			vim.cmd("TSBufEnable highlight")
		end
	end,
})

-- Manually attach ts_ls to Vue files since mason-lspconfig doesn't always pick up custom filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.vue",
	callback = function()
		-- Ensure the filetype is set correctly
		vim.bo.filetype = "vue"
		-- Attach ts_ls with the Vue TypeScript plugin after a short delay
		vim.defer_fn(function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
			-- Only attach if ts_ls is not already attached
			if #clients == 0 then
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()
				capabilities.offsetEncoding = { "utf-16" }
				-- Function to find the Vue TypeScript plugin
				local function get_vue_plugin_path()
					-- Check project-local installation first (if exists)
					local project_root = vim.fn.getcwd()
					local plugin_path = project_root .. "/node_modules/@vue/typescript-plugin"
					if vim.fn.isdirectory(plugin_path) == 1 then
						return plugin_path
					end
					-- Use the globally bundled plugin from Mason's vue-language-server
					local global_path = vim.fn.expand(
						"~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
					)
					if vim.fn.isdirectory(global_path) == 1 then
						return global_path
					end
					return ""
				end
				-- Start ts_ls for this buffer
				vim.lsp.start({
					name = "ts_ls",
					cmd = { "typescript-language-server", "--stdio" },
					root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(
						vim.api.nvim_buf_get_name(bufnr)
					),
					capabilities = capabilities,
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = get_vue_plugin_path(),
								languages = { "vue" },
							},
						},
					},
				})
			end
		end, 100) -- Small delay to ensure other LSPs are loaded first
	end,
})
