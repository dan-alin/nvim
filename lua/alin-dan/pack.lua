-- Native vim.pack: flat spec list, single vim.pack.add, explicit setup order.

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update({}, {
		config = {
			window = {
				type = "float",
				relative = "editor",
				border = "rounded",
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.9),
			},
		},
	})
end, { desc = "Update plugins with vim.pack" })

local gh = "https://github.com/"

---@type vim.pack.Spec[]
local specs = {
	{ src = gh .. "nvim-lua/plenary.nvim" },
	{ src = gh .. "kevinhwang91/promise-async" },
	{ src = gh .. "MunifTanjim/nui.nvim" },
	{ src = gh .. "nvim-tree/nvim-web-devicons" },
	{ src = gh .. "rafamadriz/friendly-snippets" },
	{ src = gh .. "L3MON4D3/LuaSnip", version = "v2.5.0" },
	{ src = gh .. "hrsh7th/cmp-buffer" },
	{ src = gh .. "hrsh7th/cmp-path" },
	{ src = gh .. "saadparwaiz1/cmp_luasnip" },
	{ src = gh .. "hrsh7th/cmp-nvim-lsp" },
	{ src = gh .. "onsails/lspkind.nvim" },
	{ src = gh .. "hrsh7th/nvim-cmp" },
	{ src = gh .. "windwp/nvim-autopairs" },
	{ src = gh .. "williamboman/mason.nvim" },
	{ src = gh .. "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = gh .. "mfussenegger/nvim-lint" },
	{ src = gh .. "stevearc/conform.nvim" },
	{ src = gh .. "lewis6991/gitsigns.nvim" },
	{ src = gh .. "rcarriga/nvim-notify" },
	{ src = gh .. "folke/which-key.nvim" },
	{ src = gh .. "jiaoshijie/undotree" },
	{ src = gh .. "folke/tokyonight.nvim" },
	{ src = gh .. "goolord/alpha-nvim" },
	{ src = gh .. "kylechui/nvim-surround" },
	{ src = gh .. "ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = gh .. "folke/lazydev.nvim" },
	{ src = gh .. "antosha417/nvim-lsp-file-operations" },
	{ src = gh .. "neovim/nvim-lspconfig" },
	{ src = gh .. "nvim-lualine/lualine.nvim" },
	{ src = gh .. "folke/todo-comments.nvim" },
	{ src = gh .. "stevearc/aerial.nvim" },
	{ src = gh .. "nvim-telescope/telescope-fzf-native.nvim" },
	{ src = gh .. "nvim-telescope/telescope.nvim" },
	{ src = gh .. "nvim-tree/nvim-tree.lua", name = "nvim-tree" },
	{ src = gh .. "nvim-treesitter/nvim-treesitter" },
	{ src = gh .. "nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = gh .. "windwp/nvim-ts-autotag" },
	{ src = gh .. "kevinhwang91/nvim-ufo" },
	{ src = gh .. "folke/noice.nvim" },
}

local ok, err = pcall(vim.pack.add, specs)
if not ok and not tostring(err):find("already exists") then
	vim.notify("vim.pack.add failed: " .. tostring(err), vim.log.levels.ERROR)
end

vim.defer_fn(function()
	local function cwd_for(name_pattern)
		for _, rtp in ipairs(vim.api.nvim_list_runtime_paths()) do
			if rtp:match(name_pattern) then
				return rtp
			end
		end
	end
	if vim.fn.has("win32") == 0 then
		local luasnip = cwd_for("LuaSnip$")
		if luasnip and vim.uv.fs_stat(luasnip .. "/Makefile") then
			vim.system({ "make", "install_jsregexp" }, { cwd = luasnip }):wait()
		end
	end
	local fzf = cwd_for("telescope%-fzf%-native")
	if fzf then
		if vim.fn.has("win32") == 1 then
			if vim.uv.fs_stat(fzf .. "/CMakeLists.txt") then
				vim.system({
					"cmd",
					"/c",
					"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
				}, { cwd = fzf }):wait()
			end
		elseif vim.uv.fs_stat(fzf .. "/Makefile") then
			vim.system({ "make" }, { cwd = fzf }):wait()
		end
	end
end, 100)

local setup_order = {
	"colorscheme",
	"nvim-notify",
	"which-key",
	"lsp.mason",
	"treesitter",
	"lazydev",
	"nvim-cmp",
	"autopairs",
	"lualine",
	"git-signs",
	"todo-comments",
	"aerial",
	"formatting",
	"linting",
	"telescope",
	"nvim-tree",
	"harpoon",
	"surround",
	"nvim-ts-autotag",
	"ufo",
	"undotree",
	"noice",
	"alpha",
	"lsp.lspconfig",
}

for _, name in ipairs(setup_order) do
	local mod = "alin-dan.plugins." .. name
	local r_ok, r = pcall(require, mod)
	if not r_ok then
		vim.notify("Failed to load " .. mod .. ": " .. tostring(r), vim.log.levels.ERROR)
	elseif type(r) == "table" and type(r.setup) == "function" then
		local s_ok, s_err = pcall(r.setup)
		if not s_ok then
			vim.notify(mod .. ".setup() failed: " .. tostring(s_err), vim.log.levels.ERROR)
		end
	end
end
