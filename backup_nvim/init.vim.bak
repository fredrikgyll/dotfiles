set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
--  vim.lsp.set_log_level("debug")
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
        DiffAdd = {fg="#b8bb26", bg="#282828"},
        DiffDelete = {fg="#fb4934", bg="#282828"},
        DiffChange = {fg="#8ec07c", bg="#282828"},
        DiffText = {fg="#fabd2f", bg="#282828"},
    }
})
-- hi DiffAdd guifg=NONE guibg=#464632 gui=NONE cterm=NONE
-- hi DiffChange guifg=NONE guibg=#335261  gui=NONE cterm=NONE
-- hi DiffDelete guifg=#f43753 guibg=#79313c gui=NONE cterm=NONE
-- hi DiffText guifg=NONE  guibg=NONE gui=reverse cterm=reverse

vim.cmd("colorscheme gruvbox")

require('neoscroll').setup()
require('nvim-web-devicons').setup()

--nvim-cmp
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      menu = ({
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      nvim_lsp_signature_help = "[LSPSH]",
      path = "[PTH]",
      luasnip = "[LuaSnip]",
      nvim_lua = "[Lua]",
      latex_symbols = "[Latex]",
      before = require("tailwind-tools.cmp").lspkind_format
    })
    })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'tailwind-tools' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- Telescope
require('telescope').setup()

local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local finders = require "telescope.finders"

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == '??' or 'A ' then
      return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value, '--', '.' }
    end

    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!', '--', '.' }

  end
}

local custom_telescope_commands = {}
custom_telescope_commands.git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_commits(opts)
end
custom_telescope_commands.git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_bcommits(opts)
end
custom_telescope_commands.git_status = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_status(opts)
end

custom_telescope_commands.no_tests_grep = function(opts)
  opts = opts or {}
  opts.glob_pattern = {"!tests/"}

  builtin.live_grep(opts)
end

vim.keymap.set('n', '<leader>l', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>?', custom_telescope_commands.no_tests_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader><ESC>', builtin.keymaps, {})
vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>T', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>t', builtin.tags, {})
vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gs', custom_telescope_commands.git_status, {})

require('telescope').load_extension('fzf')



-- LSP

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  -- debounce_text_changes = 150,
}

local nvim_lsp = require('lspconfig')
require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", },
    settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
    --analysis = {
    --  -- Ignore all files for analysis to exclusively use Ruff for linting
    --  ignore = { '*' },
    --},
    },
  },
}

require'lspconfig'.bashls.setup{
    filetypes = { "sh" },
    capabilities = capabilities,
    flags = lsp_flags,
}

require'lspconfig'.denols.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}
require'lspconfig'.ts_ls.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    single_file_support = false
}
require'lspconfig'.jsonls.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    filetypes={"json", "jsonc", "geojson"},
}
require'lspconfig'.tailwindcss.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    filetypes = {"jinja", "jinja.html", "htmljinja", "django-html", "htmldjango", "html", "markdown", "css", "less", "postcss", "sass", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact"}

}

vim.lsp.config('html', {
  capabilities = capabilities,
  filetypes = { "html", "templ", "jinja.html", "htmljinja"}
})
vim.lsp.enable('html')


-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, noremap=true, silent=true}
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
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
-- vim.lsp.set_log_level("debug")

-- Tresitter
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json", "javascript", "typescript", "jinja", "html", "htmldjango", "python", "bash", "rust", "css", "scss", "python", "jinja2"},
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
}

vim.filetype.add({
  pattern = {
    [".*/jinja2/.*/.*%.html"] = "htmljinja",
  },
})


-- require("lsp_lines").setup()
-- vim.diagnostic.config({
--   virtual_text = false,
-- })


-- vim.api.nvim_set_hl(0, "TreesitterContext", { ctermbg=Grey, bg=Grey })
-- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { gui=underline, guisp=Red })
-- vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { gui=underline, guisp=Grey })
require('lspsaga').setup({})
require('tailwind-tools').setup({
  server = {
    override = true, -- setup the server from the plugin if true
	},
	extension = {
	        patterns = { -- a map of filetypes to Lua pattern lists
      html = { "class=[\"']([^\"']+)[\"']" },
      htmljinja = { "class=[\"']([^\"']+)[\"']" },
      -- javascript = { "clsx%(([^)]+)%)" },
    },

	  }
})
EOF

