-- Which-key for discoverable keybindings
return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').setup({
        preset = 'modern',
      })

      -- Document existing key chains
      require('which-key').add({
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>s", group = "Spell/Search" },
        { "<leader>w", group = "Workspace" },
      })
    end
  }
}
