" Customize global settings
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
      \ 'clangd': {'mark': 'C'},
      \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
      \ 'around': {'maxSize': 100},
      \ })

" https://github.com/Shougo/ddc-nvim-lsp
call ddc#custom#patch_global('sources', ['nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': { 'matchers': ['matcher_head'] },
      \ 'nvim-lsp': {
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
      \ })

" Mappings
" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
" Use ddc.
call ddc#enable()
