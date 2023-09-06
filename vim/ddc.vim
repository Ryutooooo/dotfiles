call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['around', 'nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ 'around': #{ mark: '[Around]'},
      \ 'nvim-lsp': #{
      \   mark: '[LSP]',
      \   forceCompletionPattern: '\.\w*|:\w*|->\w*' },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   around: #{ maxSize: 400 },
      \   nvim-lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   }
      \ })


" Init ddc.
call ddc#enable()
