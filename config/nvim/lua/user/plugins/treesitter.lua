return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {}

      require('nvim-treesitter').install({
        "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
        "json", "javascript", "typescript", "html",
        "python", "bash", "rust", "css", "scss",
      })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local max_filesize = 200 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if ok and stats and stats.size > max_filesize then return end
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end
  },
}
