require("alin-dan.core")
require("alin-dan.lazy")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    vim.cmd("TSEnable highlight")
  end,
})
vim.diagnostic.config({
  signs = true, -- Keep signs in the gutter
  underline = true, -- Enable underlines for diagnostics
  virtual_text = {
    enabled = true,
    spacing = 4,
    source = "if_many", -- Show source when multiple sources
    prefix = "●", -- Could be '■', '▎', '●', etc.
    severity = { min = vim.diagnostic.severity.HINT }, -- Show all severities
  },
  float = {
    border = "rounded", -- Change to "single", "double", "solid", etc.
    source = "always", -- Show source in floating window
    header = "",
    prefix = "",
    focusable = false,
  },
  severity_sort = true, -- Sort diagnostics by severity
  update_in_insert = false, -- Don't update diagnostics while typing
})

-- Ensure diagnostics are shown immediately
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "InsertLeave", "TextChanged" }, {
  callback = function()
    vim.diagnostic.show()
  end,
})
-- set the cursoline to be transparent
vim.cmd("highlight CursorLine guibg=NONE ctermbg=NONE")
