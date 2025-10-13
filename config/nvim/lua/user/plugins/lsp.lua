-- LSP Configuration for Neovim 0.11+
-- Uses built-in vim.lsp.config() and vim.lsp.enable() APIs
return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Get capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- LSP keybindings (buffer-local, set on attach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf, noremap = true, silent = true }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-S>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          -- Format handled by conform.nvim (<leader>f)
        end,
      })

      -- Diagnostic keymaps (global)
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


      -- Configure language servers
      -- Customize settings before enabling

      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = {
          "pyproject.toml", "setup.py", "setup.cfg",
          "requirements.txt", "Pipfile", "pyrightconfig.json"
        },
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff's import organizer
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true
            }
          },
        },
      })

      vim.lsp.config('bashls', {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh' },
        capabilities = capabilities,
      })

      vim.lsp.config('denols', {
        cmd = { 'deno', 'lsp' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'deno.json', 'deno.jsonc' },
        capabilities = capabilities,
      })

      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'package.json' },
        capabilities = capabilities,
      })

      vim.lsp.config('jsonls', {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc', 'geojson' },
        capabilities = capabilities,
      })

      vim.lsp.config('tailwindcss', {
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = {
          "jinja", "jinja.html", "htmljinja", "django-html", "htmldjango",
          "html", "markdown", "css", "less", "postcss", "sass", "scss",
          "javascript", "javascriptreact", "typescript", "typescriptreact"
        },
        capabilities = capabilities,
      })

       vim.lsp.config('html', {
         cmd = { 'vscode-html-language-server', '--stdio' },
         filetypes = { "html", "templ", "jinja.html", "htmljinja" },
         capabilities = capabilities,
       })

      -- Enable all configured LSP servers
      vim.lsp.enable({
	      'pyright',
	      'bashls',
	      'denols',
	      'ts_ls',
	      'jsonls',
	      'tailwindcss',
	      'html',
      })
    end
  },
}
