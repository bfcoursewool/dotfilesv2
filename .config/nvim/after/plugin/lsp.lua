local lsp_zero = require('lsp-zero')
require('lspconfig').intelephense.setup({})

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})

  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>h', function() vim.lsp.buf.signature_help() end, opts)
end)

-- Restore inline diagnostic text
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,          -- distance to the line
    prefix  = "●",        -- could be '', '●', '·', or '' for no icon
    severity = nil,       -- show all severities
  },
  signs = true,           -- keep gutter signs
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
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

