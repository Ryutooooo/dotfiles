local vim = vim

local capabilities = require("ddc_source_lsp").make_client_capabilities()

-- Diagnostic keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- LSP keymaps via LspAttach autocmd (replaces on_attach)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space><space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
})

-- go fmt after modified buffer
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.go" },
  callback = function() vim.lsp.buf.format { async = true } end,
})

-- LSP hover config
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts
  opts.border = opts.border
  opts.max_width = math.floor(vim.o.columns * 2)
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- hover ui config
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)

-- diagnostic ui config
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = 'single',
  },
})

-- mason config
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = true,
})

-- Common LSP config for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- ts_ls (formerly tsserver) - only attach in Node.js projects
vim.lsp.config('ts_ls', {
  root_markers = { 'package.json' },
})

-- eslint - only attach in Node.js projects
vim.lsp.config('eslint', {
  root_markers = { 'package.json' },
})

-- denols - only attach in Deno projects
vim.lsp.config('denols', {
  root_markers = { 'deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json' },
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      import = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cnhdn.nest.land"] = true,
          ["https://crus.land"] = true,
        }
      }
    }
  },
})

-- gopls config
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- typos_lsp config
vim.lsp.config('typos_lsp', {
  settings = {
    typos_lsp = {
      config = '~/.config/nvim/.typos.toml',
    },
  },
})

-- typeprof config
vim.lsp.config('typeprof', {})
vim.lsp.enable('typeprof')

-- dartls config
local dart_capabilities = vim.lsp.protocol.make_client_capabilities()
dart_capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        "",
        "quickfix",
        "refactor",
        "refactor.extract",
        "refactor.inline",
        "refactor.rewrite",
        "source",
        "source.organizeImports",
      },
    },
  },
}

vim.lsp.config('dartls', {
  capabilities = dart_capabilities,
  filetypes = { "dart" },
  settings = {
    dart = {
      devToolsBrowser = "arc",
    },
  },
})
vim.lsp.enable('dartls')
