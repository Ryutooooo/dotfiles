local on_attach = function (client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
end

require('lspconfig').gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

require('lspconfig').pyright.setup({on_attach = on_attach})
require('lspconfig').tsserver.setup({on_attach = on_attach})
require('lspconfig').vimls.setup({on_attach = on_attach})
require('lspconfig').intelephense.setup({on_attach = on_attach})
require('lspconfig').dartls.setup({on_attach = on_attach})
require('lspconfig').yamlls.setup({on_attach = on_attach})
