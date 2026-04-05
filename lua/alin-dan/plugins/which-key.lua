return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  opts = {
    delay = 1000, -- 1 second delay
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search/Symbols" },
      { "<leader>b", group = "Buffers" },

      -- Find group (mostly file-related)
      { "<leader>ff", desc = "Files" },
      { "<leader>fr", desc = "Recent files" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fg", desc = "Git files" },
      { "<leader>fh", desc = "Help tags" },
      { "<leader>fk", desc = "Keymaps" },

      -- Search group (mostly content-related)
      { "<leader>sr", desc = "Resume last search" },
      { "<leader>ss", desc = "Document symbols (Aerial)" },
      { "<leader>sS", desc = "Workspace symbols" },
      { "<leader>st", desc = "Toggle outline (Aerial)" },
      { "<leader>/", desc = "Find string (grep)" },

      -- Git group
      { "<leader>gs", desc = "Stage hunk" },
      { "<leader>gr", desc = "Reset hunk" },
      { "<leader>gR", desc = "Reset entire file" },
      { "<leader>gp", desc = "Preview hunk" },
      { "<leader>gb", desc = "Blame line" },
    },
  },
}
