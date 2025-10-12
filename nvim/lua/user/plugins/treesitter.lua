-- Treesitter for syntax highlighting
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'geigerzaehler/tree-sitter-jinja2',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
          "json", "javascript", "typescript", "jinja", "html", "htmldjango",
          "python", "bash", "rust", "css", "scss", "jinja2"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            local max_filesize = 200 * 1024 -- 200 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = {
          enable = false
        }
      })

      -- Custom filetype detection for jinja templates
      vim.filetype.add({
        pattern = {
          [".*/jinja2/.*/.*%.html"] = "htmljinja",
        },
      })
    end
  },
}
