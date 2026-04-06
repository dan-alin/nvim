-- Resolve the @vue/typescript-plugin path directly from Mason's install directory.
-- Avoids calling mason-registry at module load time (registry may not be ready yet).
local vue_plugin_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local plugins = {}
if vim.fn.isdirectory(vue_plugin_path) == 1 then
	plugins = {
		{
			name = "@vue/typescript-plugin",
			location = vue_plugin_path,
			languages = { "vue" },
		},
	}
end

return {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	init_options = {
		plugins = plugins,
	},
}
