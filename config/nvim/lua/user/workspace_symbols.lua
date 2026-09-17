local channel = require('plenary.async.control').channel

-- Pyright only scans the project once it receives a workspace/symbol request,
-- so a throwaway query is what makes the first real search return results.
local function index_workspace(client)
  client:request('workspace/symbol', { query = 'nvim_warmup' }, function() end)
end

local function python_config()
  local config = vim.lsp.config.pyright
  if not config then
    return nil
  end

  local root = vim.fs.root(assert(vim.uv.cwd()), config.root_markers)
  if not root then
    return nil
  end

  return vim.tbl_extend('force', config, { root_dir = root })
end

-- The python server is queried through a client that is deliberately attached
-- to no buffer, so workspace symbols stay available from any filetype.
local function start_python_client(config)
  local client_id = vim.lsp.start(config, { attach = false })
  return client_id and vim.lsp.get_client_by_id(client_id) or nil
end

local function python_client()
  local config = python_config()
  if not config then
    return nil
  end

  config.on_init = index_workspace

  local client = start_python_client(config)
  if not client then
    return nil
  end

  vim.wait(5000, function()
    return client.initialized == true
  end, 50)

  if not client.initialized then
    vim.notify('pyright is still starting', vim.log.levels.INFO)
    return nil
  end

  return client
end

local function symbol_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = 'workspace/symbol' })

  local python = python_client()
  if python and not vim.iter(clients):any(function(client)
    return client.id == python.id
  end) then
    table.insert(clients, python)
  end

  return clients
end

local function requester(clients)
  local cancel = function() end

  return function(prompt)
    cancel()

    local tx, rx = channel.oneshot()
    local items = {}
    local requests = {}
    local pending = #clients

    for _, client in ipairs(clients) do
      local ok, request_id = client:request('workspace/symbol', { query = prompt }, function(err, result)
        if not err and result then
          vim.list_extend(items, vim.lsp.util.symbols_to_items(result, 0, client.offset_encoding))
        end
        pending = pending - 1
        if pending == 0 then
          tx()
        end
      end)

      if ok and request_id then
        requests[client.id] = request_id
      else
        pending = pending - 1
      end
    end

    if pending == 0 then
      tx()
    end

    cancel = function()
      for client_id, request_id in pairs(requests) do
        local client = vim.lsp.get_client_by_id(client_id)
        if client then
          client:cancel_request(request_id)
        end
      end
    end

    rx()
    return items
  end
end

local M = {}

function M.warmup()
  local config = python_config()
  if not config then
    return
  end

  config.on_init = index_workspace

  local client = start_python_client(config)
  if client and client.initialized then
    index_workspace(client)
  end
end

function M.open(opts)
  opts = opts or {}

  local clients = symbol_clients()
  if vim.tbl_isempty(clients) then
    vim.notify('no language server provides workspace symbols here', vim.log.levels.INFO)
    return
  end

  local actions = require('telescope.actions')
  local conf = require('telescope.config').values
  local finders = require('telescope.finders')
  local make_entry = require('telescope.make_entry')
  local pickers = require('telescope.pickers')

  pickers
    .new(opts, {
      prompt_title = 'Workspace Symbols',
      finder = finders.new_dynamic({
        entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
        fn = requester(clients),
      }),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_, map)
        map('i', '<c-space>', actions.to_fuzzy_refine)
        return true
      end,
    })
    :find()
end

return M
