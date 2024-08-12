return {
  "folke/tokyonight.nvim",
  priority = 1000,
  transparent = true, -- Set to true if you want the terminal's background to be transparent
  sidebars = { "nvim-tree" },
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "dark",          -- style for floating windows
  },
  config = function()
    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
