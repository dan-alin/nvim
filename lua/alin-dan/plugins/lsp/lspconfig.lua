return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    -- Suppress deprecation warnings temporarily while plugins update
    local notify_once = vim.notify_once
    vim.notify_once = function(msg, level, opts)
      if type(msg) == "string" and msg:match("jump_to_location.*deprecated") then
        return -- Suppress jump_to_location deprecation warnings
      end
      return notify_once(msg, level, opts)
    end
    
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions
        
        -- Alternative Telescope mapping
        opts.desc = "Show LSP definitions (Telescope)"
        keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions via telescope

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    
    -- Set default position encoding to help with warnings
    capabilities.offsetEncoding = { "utf-16" }
    
    -- Increase LSP timeout for better reliability
    vim.lsp.set_log_level("WARN") -- Reduce log verbosity

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    -- Configure diagnostic signs (this extends the global config from init.lua)
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Add custom vue_ls configuration
    local configs = require('lspconfig.configs')
    if not configs.vue_ls then
      configs.vue_ls = {
        default_config = {
          cmd = { 'vue-language-server', '--stdio' },
          filetypes = { 'vue' },
          root_dir = lspconfig.util.root_pattern('package.json', 'vue.config.js', 'vite.config.js', 'nuxt.config.js', '.git'),
          settings = {},
          init_options = {
            typescript = {
              tsdk = vim.fn.expand("~/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib"),
            },
          },
        },
      }
    end
    
    -- Setup individual LSP servers directly
    
    -- IMPORTANT: Configure TypeScript FIRST - required by vue_ls
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand("~/.volta/tools/image/packages/@vue/language-server/lib/node_modules/@vue/language-server"),
            languages = { "vue" },
          },
        },
      },
      on_attach = function(client, bufnr)
        -- enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        
        -- Enable formatting if the client supports it
        if client.server_capabilities.documentFormattingProvider then
          vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
        end
        
        -- Force diagnostics to show for this buffer
        vim.diagnostic.show(nil, bufnr)
      end,
    })
    
    -- Configure Tailwind CSS language server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
    })
    
    -- Configure Rust analyzer
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })
    
    -- Configure Svelte language server
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, _)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts", "*.svelte" },
          callback = function(ctx)
            -- Use ctx.file to get the file path
            client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.file) })
          end,
        })
      end,
    })
    
    -- Configure GraphQL language server
    lspconfig["graphql"].setup({
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })
    
    -- Configure Emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "svelte", "vue", "css", "sass", "scss", "less" },
    })
    
    -- Configure HTML language server
    lspconfig["html"].setup({
      capabilities = capabilities,
    })
    
    -- Configure CSS language server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
    })
    
    -- Configure Prisma language server
    lspconfig["prismals"].setup({
      capabilities = capabilities,
    })
    
    -- Configure Lua language server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
    
    -- Vue support is handled by ts_ls with @vue/typescript-plugin
    -- No separate Vue LSP server needed in modern setup
  end,
}
