local M = {}

local function open_lsp_attached_window()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local lines = {}
	local n = #clients
	table.insert(lines, ("Buffer %d — %s"):format(bufnr, n == 0 and "no LSP" or (n == 1 and "1 client" or n .. " clients")))
	table.insert(lines, string.rep("─", math.min(56, vim.o.columns - 8)))
	if n == 0 then
		table.insert(lines, "")
		table.insert(lines, "No language server is attached to this buffer.")
	else
		for _, c in ipairs(clients) do
			table.insert(lines, "")
			table.insert(lines, "• " .. c.name)
			table.insert(lines, "  id: " .. tostring(c.id))
			local root = c.root_dir
			if type(root) == "string" and root ~= "" then
				table.insert(lines, "  root: " .. root)
			end
		end
	end
	table.insert(lines, "")
	table.insert(lines, "q or Esc — close")

	local scratch = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(scratch, 0, -1, false, lines)
	vim.bo[scratch].modifiable = false
	vim.bo[scratch].bufhidden = "wipe"
	vim.bo[scratch].buftype = "nofile"
	vim.bo[scratch].swapfile = false
	vim.bo[scratch].filetype = "text"

	local width = math.min(72, vim.o.columns - 4)
	local height = math.min(math.max(#lines, 4), vim.o.lines - 6)
	local row = math.max(0, math.floor((vim.o.lines - height) / 2))
	local col = math.max(0, math.floor((vim.o.columns - width) / 2))

	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}
	if vim.fn.has("nvim-0.9") == 1 then
		win_opts.title = " LSP attached "
		win_opts.title_pos = "center"
	end

	vim.api.nvim_open_win(scratch, true, win_opts)
	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = scratch, silent = true })
	vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = scratch, silent = true })
end

function M.setup()
	require("lsp-file-operations").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local keymap = vim.keymap

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
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

	vim.api.nvim_create_user_command("LspAttached", open_lsp_attached_window, {
		desc = "Floating window: LSP clients attached to the current buffer",
	})

	vim.keymap.set("n", "<leader>la", open_lsp_attached_window, { desc = "LSP: show attached clients" })

	vim.lsp.log.set_level("WARN")

	vim.lsp.config("*", {
		capabilities = cmp_nvim_lsp.default_capabilities(),
	})

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
end

return M
