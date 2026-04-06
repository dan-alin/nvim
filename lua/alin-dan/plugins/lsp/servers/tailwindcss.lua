return {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
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
}
