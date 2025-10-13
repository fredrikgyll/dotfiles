-- Mason for LSP/tool installation
return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        -- Automatically install these LSP servers
        ensure_installed = {
          'pyright',
          'bashls',
          'ts_ls',
          'jsonls',
          'html',
          'tailwindcss',
        },
        automatic_installation = true,
      })
    end
  }
}
