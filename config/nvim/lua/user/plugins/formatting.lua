-- Formatting with conform.nvim
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          python = { 'ruff_format', 'ruff_organize_imports' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          json = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          markdown = { 'prettier' },
          lua = { 'stylua' },
        },
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype == 'python' then
            return { timeout_ms = 500, lsp_format = false }
          end
        end,
      })
    end
  }
}
