local lsp_zero = require('lsp-zero')
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('intelephense', {
  cmd = { 'intelephense', '--stdio' },
  capabilities = capabilities,
})

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', '<leader>gd', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>ld', '<cmd>Telescope diagnostics<cr>', { buffer = 0 })
  vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { buffer = 0 })
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
end)

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = capabilities,
  settings = {
    gopls = {
      -- Enable experimental workspace module support
      ["build.experimentalWorkspaceModule"] = true,
      -- Disable go.mod validation that causes the "unknown block type: tool" error
      ["ui.diagnostic.staticcheck"] = false,
      -- Additional settings to help with experimental features
      buildFlags = {"-tags=tools"},
    },
  },
})

-- Add a global diagnostic handler to filter out the tool block error
local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  if result and result.diagnostics then
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      return not (diagnostic.message and string.match(diagnostic.message, "unknown block type"))
    end, result.diagnostics)
  end
  original_handler(err, result, ctx, config)
end

-- Configure diagnostic display (only do this once)
vim.diagnostic.config({
  virtual_text = {
    spacing  = 2,
    prefix   = "●",
    severity = nil,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
    'ts_ls',
    'bashls',
    'solidity_ls_nomicfoundation',
    'cssls',
    'dockerls',
    'eslint',
    'gopls',
    'html',
    'jsonls',
    'pylyzer',
    'yamlls',
    'vimls',
    'lua_ls',
    'rust_analyzer',
  },
  handlers = {
    function(server_name)
      vim.lsp.config(server_name, {})
      vim.lsp.enable(server_name)
    end,
  }
})
