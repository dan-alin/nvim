require("alin-dan.core")
require("alin-dan.lazy")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    vim.cmd("TSEnable highlight")
  end
})
