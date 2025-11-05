return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },
        {
          filter = { event = "notify" },
          opts = { skip = true },
        },
      },
      views = {
        notify = {
          position = {
            row = "100%",
            col = "100%",
          },
          size = {
            width = "auto",
            height = "auto",
          },
          anchor = "SE", -- Southeast (bottom right)
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Ensure nvim-notify loads first
    },
  },
}
