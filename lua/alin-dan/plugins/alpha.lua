return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local builtin = require("telescope.builtin")
    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰱼   Find File", "<cmd>lua require('telescope.builtin').find_files()<CR>"),
      dashboard.button("e", "   File Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("/", "   Live Grep ", "<cmd>lua require('telescope.builtin').live_grep()<CR>"),
      dashboard.button("g", "󰱼   Find Git Files", "<cmd>lua require('telescope.builtin').git_files()<CR>"),
      dashboard.button("l", "   Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("m", "   Mason", "<cmd>Mason<CR>"),
      dashboard.button("q", "   Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
