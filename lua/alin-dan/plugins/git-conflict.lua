return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function()
    require('git-conflict').setup({
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen', -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })

    -- Custom keymaps for conflict resolution
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- Navigate conflicts
    keymap.set('n', '<leader>gn', '<cmd>GitConflictNextConflict<CR>', vim.tbl_extend('force', opts, { desc = 'Next git conflict' }))
    keymap.set('n', '<leader>gp', '<cmd>GitConflictPrevConflict<CR>', vim.tbl_extend('force', opts, { desc = 'Previous git conflict' }))

    -- Choose sides
    keymap.set('n', '<leader>gco', '<cmd>GitConflictChooseOurs<CR>', vim.tbl_extend('force', opts, { desc = 'Choose our changes' }))
    keymap.set('n', '<leader>gct', '<cmd>GitConflictChooseTheirs<CR>', vim.tbl_extend('force', opts, { desc = 'Choose their changes' }))
    keymap.set('n', '<leader>gcb', '<cmd>GitConflictChooseBoth<CR>', vim.tbl_extend('force', opts, { desc = 'Choose both changes' }))
    keymap.set('n', '<leader>gc0', '<cmd>GitConflictChooseNone<CR>', vim.tbl_extend('force', opts, { desc = 'Choose none (delete)' }))

    -- List all conflicts in quickfix
    keymap.set('n', '<leader>gcl', '<cmd>GitConflictListQf<CR>', vim.tbl_extend('force', opts, { desc = 'List git conflicts' }))
  end,
}
