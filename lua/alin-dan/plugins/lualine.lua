return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        theme = "ayu_mirage",
        disabled_filetypes = { "alpha", "lazy" },
      },
    })
  end,
}
