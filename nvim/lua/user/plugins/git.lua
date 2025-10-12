-- Git plugins
return {
  -- Fugitive - Core git plugin
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gti', 'GIt', 'GTi', 'G', 'Gedit', 'Gdiff', 'Gblame', 'Gbrowse' },
    keys = {
      { '<leader>gg', ':vert Git<CR>', desc = 'Git status' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
      { '<leader>gh', 'V:Gbrowse<CR>', mode = 'n', desc = 'GitHub browse' },
    },
    config = function()
      -- Command aliases for common typos
      vim.cmd('command! -nargs=* -complete=option Gti Git <args>')
      vim.cmd('command! -nargs=* -complete=option GIt Git <args>')
      vim.cmd('command! -nargs=* -complete=option GTi Git <args>')
      vim.cmd('command! -nargs=* -complete=option G Git <args>')

      -- Custom keymap for special git command
      vim.keymap.set('n', 'g<C-q>', 'ZZ:Gedit<CR>', { noremap = true })
    end
  },

  -- Rhubarb - GitHub integration for fugitive
  {
    'tpope/vim-rhubarb',
    dependencies = { 'tpope/vim-fugitive' },
  },

  -- Gitsigns - Modern Lua git integration (replaces vim-gitgutter)
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        map('n', '<leader>hd', gs.diffthis)
      end
    }
  },
}
