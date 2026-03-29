return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { "<leader>", group = "Leader" },
      { "<leader>gd", desc = "LSP definition (Telescope)" },
      { "g", group = "goto" },
      { "gd", desc = "LSP definition (jump)" },
      { "[", group = "prev" },
      { "]", group = "next" },
    },
  },
}
