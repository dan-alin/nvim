return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local ayu = require("lualine.themes.ayu_dark")
    ayu.normal.c.bg = "none"
    ayu.normal.a.bg = "#4fd6be"
    ayu.insert.a.bg = "#c3e88d"
    ayu.visual.a.bg = "#ff9e64"
    ayu.replace.a.bg = "#9d7cd8"

    require("lualine").setup({
      sections = {
        lualine_c = {
          {
            "filename",
            path = 4
          }
        }
      },
      options = {
        section_separators = { "", "" },
        component_separators = { "", "" },
        globalstatus = true,
        theme = ayu,
        disabled_filetypes = { "alpha", "lazy", "mason", "TelescopePrompt", "TelescopeResults", "NvimTree" },
      },
    })
  end,
}
