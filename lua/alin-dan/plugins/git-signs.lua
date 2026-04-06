return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local git_signs = require("gitsigns")

      git_signs.setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        numhl = false,             -- Highlight numbers for changes
        linehl = false,            -- Highlight lines for changes
        current_line_blame = false, -- Toggle with <leader>gb (lighter than always-on)
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        sign_priority = 6,       -- Priority of signs
        update_debounce = 100,   -- Debounce time for updates (in ms)
        max_file_length = 40000, -- Max file length to enable gitsigns

        on_attach = function(bufnr)
          local gs = require("gitsigns")

          -- Add keymaps
          vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>",
            { buffer = bufnr, desc = "Preview hunk" })
          vim.keymap.set("n", "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<CR>",
            { buffer = bufnr, desc = "Blame" })
          vim.keymap.set("n", "<leader>gs", gs.stage_hunk,
            { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { buffer = bufnr, desc = "Stage selected hunk" })
          vim.keymap.set("n", "<leader>gr", gs.reset_hunk,
            { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { buffer = bufnr, desc = "Reset selected hunk" })
          vim.keymap.set("n", "<leader>gR", gs.reset_buffer,
            { buffer = bufnr, desc = "Reset all changes in buffer" })
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
          end, { buffer = bufnr, desc = "Next hunk" })
          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
          end, { buffer = bufnr, desc = "Previous hunk" })
        end
      })
    end
  }
}
