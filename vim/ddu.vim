" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
call ddu#custom#patch_global({
    \ 'ui': 'ff',
    \   'uiParams': {
    \     'ff': {
    \       'filterFloatingPosition': 'top',
    \       'filterSplitDirection': 'floating',
    \       'split': 'floating',
    \       'previewFloating': v:true,
    \       'previewVertical': v:true,
    \       'previewHeight': &lines / 8 * 6,
    \       'previewWidth': &columns / 8 * 3,
    \       'winHeight': &lines / 8 * 6,
    \       'winWidth': &columns / 8 * 6 / 2,
    \       'winRow': &lines / 8,
    \       'winCol': &columns / 8,
    \     },
    \   },
    \ })

" NOTE: matcher_substring filter
" https://github.com/Shougo/ddu-filter-matcher_substring
call ddu#custom#patch_global({
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   }
    \ })

" NOTE: source
" https://github.com/Shougo/ddu-source-file_rec
call ddu#custom#patch_global({
    \ 'sources': [{'name': 'file_rec', 'params': {}}],
    \ })

" NOTE: file kind
" https://github.com/Shougo/ddu-kind-file
call ddu#custom#patch_global({
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> v
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction


autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
endfunction
