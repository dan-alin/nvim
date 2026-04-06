return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"williamboman/mason.nvim",
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Disable semantic tokens: treesitter handles all highlighting.
				-- Semantic tokens from ts_ls/svelte-ls override treesitter and render as
				-- white text when the colorscheme lacks @lsp.type.* highlight groups.
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client then
					client.server_capabilities.semanticTokensProvider = nil
				end

				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Definition: jump (not Telescope)"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Definition: Telescope (pick location)"
				keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

				opts.desc = "Show document symbols (Telescope)"
				keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", opts)

				opts.desc = "Show workspace symbols (Telescope)"
				keymap.set("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
			end,
		})

		-- LspRestart: stop all clients on current buffer and re-trigger attach
		vim.api.nvim_create_user_command("LspRestart", function()
			local buf = vim.api.nvim_get_current_buf()
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
				vim.lsp.stop(client.id)
			end
			vim.defer_fn(function()
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_call(buf, function()
						vim.cmd("edit")
					end)
				end
			end, 100)
		end, { desc = "Restart LSP for current buffer" })

		vim.lsp.log.set_level("WARN")

		-- Apply shared capabilities to all servers
		vim.lsp.config("*", {
			capabilities = cmp_nvim_lsp.default_capabilities(),
		})

		-- Per-server custom configs
		local servers_with_config = {
			"ts_ls",
			"vue_ls",
			"gopls",
			"rust_analyzer",
			"lua_ls",
			"tailwindcss",
			"emmet_ls",
			"svelte",
		}
		for _, name in ipairs(servers_with_config) do
			vim.lsp.config(name, require("alin-dan.plugins.lsp.servers." .. name))
		end

		-- Enable all servers (Mason installs the binaries)
		vim.lsp.enable({
			"ts_ls",
			"vue_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"emmet_ls",
			"rust_analyzer",
			"gopls",
		})
	end,
}
