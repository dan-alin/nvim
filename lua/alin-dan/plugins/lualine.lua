local M = {}

--- Per-client $/progress depth (see nvim-lualine `lsp_status`).
local lsp_work_by_client_id = {}

local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local busy_timer = nil

local function any_progress_busy()
	for _, w in pairs(lsp_work_by_client_id) do
		if w > 0 then
			return true
		end
	end
	return false
end

local function buf_busy(bufnr)
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		local w = lsp_work_by_client_id[c.id]
		if w and w > 0 then
			return true
		end
	end
	return false
end

local function stop_busy_timer()
	if busy_timer then
		busy_timer:stop()
		busy_timer:close()
		busy_timer = nil
	end
end

local function ensure_busy_timer()
	if busy_timer then
		return
	end
	busy_timer = assert(vim.loop.new_timer())
	busy_timer:start(80, 80, function()
		vim.schedule(function()
			if not any_progress_busy() then
				stop_busy_timer()
			end
			pcall(require("lualine").refresh)
		end)
	end)
end

local function register_lsp_progress_tracking()
	local group = vim.api.nvim_create_augroup("alin_dan_lualine_lsp_busy", { clear = true })

	vim.api.nvim_create_autocmd("LspProgress", {
		group = group,
		desc = "Lualine: LSP busy spinner from $/progress",
		callback = function(event)
			local kind = event.data.params.value.kind
			local client_id = event.data.client_id
			local work = lsp_work_by_client_id[client_id] or 0
			local delta = kind == "begin" and 1 or (kind == "end" and -1 or 0)
			lsp_work_by_client_id[client_id] = math.max(work + delta, 0)

			if any_progress_busy() then
				ensure_busy_timer()
			else
				stop_busy_timer()
			end
			pcall(require("lualine").refresh)
		end,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = group,
		desc = "Lualine: clear LSP progress state on detach",
		callback = function(ev)
			lsp_work_by_client_id[ev.data.client_id] = nil
			if not any_progress_busy() then
				stop_busy_timer()
			end
			pcall(require("lualine").refresh)
		end,
	})
end

local function lsp_ready_component()
	local buf = vim.api.nvim_get_current_buf()

	if buf_busy(buf) then
		local hrtime = (vim.uv or vim.loop).hrtime
		local i = math.floor(hrtime() / (1e6 * 80)) % #spinner_frames + 1
		return spinner_frames[i]
	end

	if #vim.lsp.get_clients({ bufnr = buf }) > 0 then
		return "✓"
	end

	return ""
end

function M.setup()
	register_lsp_progress_tracking()

	local ayu = require("lualine.themes.ayu_dark")

	ayu.normal.a.bg = "#4fd6be"
	ayu.insert.a.bg = "#c3e88d"
	ayu.visual.a.bg = "#ff9e64"
	ayu.replace.a.bg = "#9d7cd8"

	require("lualine").setup({
		sections = {
			lualine_c = {
				{
					"filename",
					path = 4,
				},
			},
			lualine_x = {
				{
					lsp_ready_component,
					cond = function()
						local buf = vim.api.nvim_get_current_buf()
						return buf_busy(buf) or #vim.lsp.get_clients({ bufnr = buf }) > 0
					end,
					color = function()
						local buf = vim.api.nvim_get_current_buf()
						if buf_busy(buf) then
							return { fg = "#7aa2f7" }
						end
						return { fg = "#9ece6a" }
					end,
					on_click = function(_, _, button)
						if button == "l" then
							vim.cmd.LspAttached()
						end
					end,
				},
				"filetype",
			},
		},
		options = {
			section_separators = { "", "" },
			component_separators = { "", "" },
			globalstatus = true,
			theme = ayu,
			disabled_filetypes = { "alpha", "mason", "TelescopePrompt", "TelescopeResults", "NvimTree" },
			refresh = {
				statusline = 200,
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"CursorMoved",
					"CursorMovedI",
					"ModeChanged",
					"LspAttach",
					"LspDetach",
					"LspProgress",
				},
			},
		},
	})
end

return M
