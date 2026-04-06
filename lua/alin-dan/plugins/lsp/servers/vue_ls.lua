return {
	filetypes = { "vue" },
	-- Hybrid mode: vue_ls handles Vue template/script blocks,
	-- ts_ls handles TypeScript via @vue/typescript-plugin injection.
	init_options = {
		vue = {
			hybridMode = true,
		},
	},
}
