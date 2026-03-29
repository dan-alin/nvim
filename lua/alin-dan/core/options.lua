vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- global statusline (matches lualine globalstatus); avoids laststatus changing at plugin load
opt.laststatus = 3

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard: sync yank/delete with system
opt.clipboard:append("unnamedplus")

-- turn off swapfile
opt.swapfile = false

-- folding configuration with TreeSitter and nvim-ufo
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99 -- start with all folds open
opt.foldcolumn = "0" -- show fold column
opt.foldlevelstart = 99 -- start with all folds open
opt.fillchars = { fold = " ", foldopen = "▾", foldsep = " ", foldclose = "▸" }
