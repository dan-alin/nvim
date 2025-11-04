-- Angular filetype detection
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.component.html", "*.template.html"},
  callback = function()
    vim.bo.filetype = "htmlangular"
  end,
})

-- Detect Angular project context for HTML files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.html",
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(buf_name, ':p:h')
    
    -- Look for Angular project markers
    local function find_angular_root(path)
      local markers = {"angular.json", "project.json", "nx.json"}
      for _, marker in ipairs(markers) do
        if vim.fn.filereadable(path .. "/" .. marker) == 1 then
          return true
        end
      end
      
      local parent = vim.fn.fnamemodify(path, ':h')
      if parent ~= path and parent ~= "/" then
        return find_angular_root(parent)
      end
      
      return false
    end
    
    -- Check if we're in an Angular project and this HTML might be a template
    if find_angular_root(dir) then
      local basename = vim.fn.fnamemodify(buf_name, ':t:r')
      local ts_file = dir .. "/" .. basename .. ".ts"
      local component_file = dir .. "/" .. basename .. ".component.ts"
      
      -- Check if there's a corresponding TypeScript component file
      if vim.fn.filereadable(ts_file) == 1 or vim.fn.filereadable(component_file) == 1 then
        vim.bo.filetype = "htmlangular"
      elseif basename == "app" or string.match(buf_name, "%.component%.html$") then
        vim.bo.filetype = "htmlangular"
      end
    end
  end,
})