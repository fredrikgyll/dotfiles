-- Telescope fuzzy finder
return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,  -- Load immediately to avoid issues
    priority = 100,
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = false },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local previewers = require('telescope.previewers')

      -- Custom delta previewer for git commands
      local delta = previewers.new_termopen_previewer({
        get_command = function(entry)
          -- For git status
          if entry.status == '??' or entry.status == 'A ' then
            return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value, '--', '.' }
          end
          -- For git commits and git bcommits
          return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!', '--', '.' }
        end
      })

      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = actions.select_default,
            },
            n = {
              ["<CR>"] = actions.select_default,
            },
          },
        },
      })
      telescope.load_extension('fzf')

      -- Custom telescope commands
      local custom = {}

      custom.git_commits = function(opts)
        opts = opts or {}
        opts.previewer = delta
        builtin.git_commits(opts)
      end

      custom.git_bcommits = function(opts)
        opts = opts or {}
        opts.previewer = delta
        builtin.git_bcommits(opts)
      end

      custom.git_status = function(opts)
        opts = opts or {}
        opts.previewer = delta
        builtin.git_status(opts)
      end

      -- Grep excluding tests directory
      custom.no_tests_grep = function(opts)
        opts = opts or {}
        opts.glob_pattern = { "!tests/" }
        builtin.live_grep(opts)
      end

      -- Custom function to find files matching word under cursor (from my_functions.lua)
      custom.find_files_expanded_word = function()
        local word = vim.fn.expand("<cword>")
        local line = vim.fn.getline(".")
        local pattern = "['\"]([^'\"]-)['\"]"
        local expanded_word = word

        for match in string.gmatch(line, pattern) do
          if string.find(match, word) then
            expanded_word = match
            break
          end
        end

        builtin.find_files({
          find_command = { 'fd', '-tf', '-p', expanded_word }
        })
      end

      -- Keymaps - CRITICAL WORKFLOW KEYBINDINGS
      local keymap = vim.keymap.set
      keymap('n', '<leader>l', builtin.find_files, {})                -- Most important!
      keymap('n', '<leader>/', builtin.live_grep, {})                 -- Most important!
      keymap('n', '<leader>?', custom.no_tests_grep, {})              -- Most important!
      keymap('n', '<leader>fb', builtin.buffers, {})
      keymap('n', '<leader>fh', builtin.help_tags, {})
      keymap('n', '<leader><ESC>', builtin.keymaps, {})
      keymap('n', '<leader>ss', builtin.spell_suggest, {})
      keymap('n', '<leader>T', builtin.lsp_document_symbols, {})
      keymap('n', '<leader>t', builtin.tags, {})
      keymap('n', '<leader>r', builtin.lsp_references, {})
      keymap('n', '<leader>gs', custom.git_status, {})
      keymap('n', '<leader>gt', custom.find_files_expanded_word, {})
    end
  },
}
