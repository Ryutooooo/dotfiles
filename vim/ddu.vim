call ddu#custom#patch_global({
    \  'profile': v:true,
    \  'ui': 'ff',
    \  'uiParams': {
    \    'ff': {
    \      'autoAction': {'name': 'preview'},
    \      'filterFloatingPosition': "top",
    \      'filterSplitDirection': "floating",
    \      'floatingBorder': "single",
    \      'previewCol': &columns / 2,
    \      'previewFloating': v:true,
    \      'previewFloatingBorder': "single",
    \      'previewSplit': "vertical",
    \      'previewHeight': &lines / 8 * 6,
    \      'previewWidth': &columns / 8 * 3,
    \      'split': "floating",
    \      'winCol': &columns / 8,
    \      'winHeight': &lines / 8 * 6,
    \      'winRow': &lines / 8,
    \      'winWidth': &columns / 8 * 3,
    \    },
    \    'filer': {
    \      'split': 'vertical',
    \      'splitDirection': 'topleft',
    \      'winWidth': &columns / 10,
    \    },
    \  },
    \  'sources': [
    \    {
    \      'name': 'file_rec',
    \      'params': {'ignoredDirectories': ['.git', 'node_modules']}
    \    },
    \  ],
    \  'sourceParams': {
    \    'rg' : {
    \      'args': ['--column', '--no-heading', '--color', 'never'],
    \    },
    \    'file_rg': {
    \      'cmd': ['rg', '--files', '--glob', '!.git', '--color', 'never', '--no-messages'],
    \    },
    \  },
    \  'sourceOptions': {
    \    '_': {
    \      'ignoreCase': v:true,
    \      'matchers': ['matcher_substring'],
    \    },
    \  },
    \  'kindOptions': {
    \    'file': {
    \      'defaultAction': 'open',
    \    },
    \  },
    \  'filterParams': {
    \    'matcher_substring': {
    \      'highlightMatched': 'Search',
    \    },
    \  },
    \  })


autocmd FileType ddu-ff call s:ddu_ff_settings()
function! s:ddu_ff_settings() abort
  nnoremap <buffer> <CR> <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer> v
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer> x
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'split'}})<CR>
  nnoremap <buffer> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_settings()
function! s:ddu_filter_settings() abort
  inoremap <buffer> <CR>
  \ <Esc><Cmd>close<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_filer_settings()
function! s:ddu_filer_settings() abort
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
  nnoremap <buffer> <Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> l
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction
