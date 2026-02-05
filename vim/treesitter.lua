-- Enable treesitter highlighting for all filetypes with available parsers
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
