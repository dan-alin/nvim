-- TOKYONIGHT
return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = true -- set to true if you would like to enable transparency

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function() end,
			on_highlights = function() end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}

-- ROSE PINE
-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	priority = 1000,
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			variant = "main",
-- 			extend_background_behind_borders = false,
-- 			palette = {
-- 				-- Override the builtin palette per variant
-- 				main = {
-- 					base = "#16161e",
-- 				},
-- 			},
-- 			styles = {
-- 				transparency = true,
-- 			},
-- 			groups = {
-- 				panel = "base",
-- 				border = "pine",
-- 			},
-- 		})
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
