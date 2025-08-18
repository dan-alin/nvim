-- Ensure proper filetype detection and syntax highlighting
vim.filetype.add({
  extension = {
    svelte = 'svelte',
  },
})

-- Ensure Treesitter highlighting is enabled for Svelte files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.svelte",
  callback = function()
    vim.bo.filetype = "svelte"
    -- Force enable Treesitter highlighting for this buffer
    if vim.fn.exists(":TSBufEnable") == 2 then
      vim.cmd("TSBufEnable highlight")
    end
  end,
})
