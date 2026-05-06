return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
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
          htmldjango = { 'trim_whitespace' },
          css = { 'prettier' },
          markdown = { 'prettier' },
          lua = { 'stylua' },
        },
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if ft == 'python' then
            return { timeout_ms = 500, lsp_format = false }
          elseif ft == 'htmldjango' then
            return { timeout_ms = 500, lsp_format = false }
          end
        end,
      })
    end
  }
}
