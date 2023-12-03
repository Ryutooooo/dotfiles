call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['around', 'nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', #{
      \  _: #{
      \    matchers: ['matcher_head'],
      \    sorters: ['sorter_rank']
      \  },
      \  around: #{ mark: '[Around]'},
      \  nvim-lsp: #{
      \    mark: '[LSP]',
      \    forceCompletionPattern: '\.\w*|:\w*|->\w*'
      \  },
      \  })
call ddc#custom#patch_global('sourceParams', #{
      \  around: #{ maxSize: 400 },
      \  nvim-lsp: #{
      \    snippetEngine: denops#callback#register({
      \      body -> vsnip#anonymous(body)
      \    }),
      \    enableResolveItem: v:true,
      \    enableAdditionalTextEdit: v:true,
      \    confirmBehavior: 'replace',
      \  }
      \  })

" Init ddc.
call ddc#enable()

lua << EOF
local ddc_previewer_floating = require("ddc_previewer_floating")
ddc_previewer_floating.enable()
ddc_previewer_floating.setup({
  max_width = vim.o.columns,
  max_height = vim.o.lines,
})
EOF
