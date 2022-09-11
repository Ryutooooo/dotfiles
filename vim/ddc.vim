call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', ['around', 'clangd', 'nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ 'around': {'mark': 'A'},
      \ 'nvim-lsp': {
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
      \ })

" Init ddc.
call ddc#enable()
