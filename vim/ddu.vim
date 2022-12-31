call ddu#custom#patch_global({
    \  'profile': v:true,
    \  'ui': 'ff',
    \  'uiParams': {
    \    'ff': {
    \      'autoAction': {'name': 'preview'},
    \      'autoResize': v:false,
    \      'filterFloatingPosition': 'top',
    \      'filterSplitDirection': 'floating',
    \      'floatingBorder': 'single',
    \      'startFilter': v:true,
    \      'split': 'floating',
    \      'previewFloating': v:true,
    \      'previewFloatingBorder': 'single',
    \      'previewVertical': v:true,
    \      'previewHeight': &lines / 8 * 7,
    \      'previewWidth': &columns / 8 * 4,
    \      'prompt': '> ',
    \      'winHeight': &lines / 8 * 7,
    \      'winWidth': &columns / 8 * 6 / 2,
    \      'winRow': &lines / 10,
    \      'winCol': &columns / 12,
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
    \    {
    \      'name': 'buffer'
    \    },
    \    {
    \      'name': 'rg'
    \    },
    \  ],
    \  'sourceParams': {
    \    'rg' : {
    \      'args': ['--column', '--no-heading', '--color', 'never', '--json'],
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
    \    'action': {
    \      'defaultAction': 'do',
    \    },
    \  },
    \  'filterParams': {
    \    'matcher_substring': {
    \      'highlightMatched': 'Search',
    \    },
    \  },
    \  })


autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> v
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> x
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'split'}})<CR>
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

autocmd FileType ddu-filer call s:ddu_filer_settings()
function! s:ddu_filer_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> l
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction
