-- Colorscheme configuration
-- Gruvbox setup migrated from init.vim

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    operators = false,
    comments = true
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "medium", -- can be "hard", "soft" or empty string
  dim_inactive = false,
  transparent_mode = false,
  overrides = {
    DiffAdd = { fg = "#b8bb26", bg = "#282828" },
    DiffDelete = { fg = "#fb4934", bg = "#282828" },
    DiffChange = { fg = "#8ec07c", bg = "#282828" },
    DiffText = { fg = "#fabd2f", bg = "#282828" },
  }
})

vim.cmd("colorscheme gruvbox")
