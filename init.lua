require("alin-dan.core")
require("alin-dan.lazy")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    vim.cmd("TSEnable highlight")
  end,
})
vim.diagnostic.config({
  signs = true, -- Keep signs in the gutter
  underline = false,
  float = {
    border = "rounded", -- Change to "single", "double", "solid", etc.
  },
})
-- set the cursoline to be transparent
vim.cmd("highlight CursorLine guibg=NONE ctermbg=NONE")
