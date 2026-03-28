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
		if vim.fn.exists(":TSBufEnable") == 2 then
			vim.cmd("TSBufEnable highlight")
		end
	end,
})

-- Manually attach ts_ls to Vue files since mason-lspconfig doesn't always pick up custom filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.vue",
	callback = function()
		vim.bo.filetype = "vue"
		vim.defer_fn(function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
			if #clients == 0 then
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()
				capabilities.offsetEncoding = { "utf-16" }

				local function get_vue_plugin_path()
					local project_root = vim.fn.getcwd()
					local plugin_path = vim.fs.joinpath(project_root, "node_modules", "@vue", "typescript-plugin")
					if vim.fn.isdirectory(plugin_path) == 1 then
						return plugin_path
					end
					local global_path = vim.fs.joinpath(
						vim.fn.stdpath("data"),
						"mason",
						"packages",
						"vue-language-server",
						"node_modules",
						"@vue",
						"language-server",
						"node_modules",
						"@vue",
						"typescript-plugin"
					)
					if vim.fn.isdirectory(global_path) == 1 then
						return global_path
					end
					return ""
				end

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
		end, 100)
	end,
})
