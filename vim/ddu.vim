call ddu#custom#patch_global({
      \  'uiParams': {
      \    'ff': {
      \      'autoAction': {'name': 'preview'},
      \      'filterFloatingPosition': "top",
      \      'filterSplitDirection': "floating",
      \      'floatingBorder': "single",
      \      'previewFloating': v:true,
      \      'previewFloatingBorder': "single",
      \      'previewSplit': "vertical",
      \      'split': "floating",
      \      'startAutoAction': v:true,
      \    },
      \    'filer': {
      \      'sort': 'filename',
      \      'split': 'vertical',
      \      'splitDirection': 'topleft',
      \    },
      \  },
      \  'sourceParams': {
      \    'rg' : {
      \    'args': ['--column', '--no-heading', '--color', 'never'],
      \    },
      \    'file_rg': {
      \      'cmd': ['rg', '--files', '--glob', '!.git', '--color', 'never', '--no-messages'],
      \    },
      \    'file_rec': {
      \      'ignoredDirectories': ['.git', 'node_modules']
      \    },
      \  },
      \  'sourceOptions': {
      \    '_': {
      \      'ignoreCase': v:true,
      \      'matchers': ['matcher_substring'],     
      \ },
      \  },
      \  'kindOptions': {
      \    'action': #{ defaultAction: 'do', },
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

call ddu#custom#alias('column', 'icon_filename_for_ff', 'icon_filename')
call ddu#custom#patch_global(#{
  \   sourceOptions: #{
  \     file: #{
  \       columns: ['icon_filename']
  \     },
  \     file_rec: #{
  \       columns: ['icon_filename_for_ff']
  \     },
  \   },
  \   columnParams: #{
  \     icon_filename: #{
  \       defaultIcon: #{ icon: '' },
  \     },
  \     icon_filename_for_ff: #{
  \       defaultIcon: #{ icon: '' },
  \       padding: 1,
  \       pathDisplayOption: 'relative'
  \     }
  \   }
  \ })

autocmd VimEnter,VimResized * call SetDDUUISize()
function! SetDDUUISize()
let g:DDUUIFFSizeConfig = { 
      \      'previewCol': &columns / 2,
      \      'previewHeight': &lines / 10 * 9,
      \      'previewWidth': &columns / 10 * 4,
      \      'winCol': &columns / 10 * 1,
      \      'winHeight': &lines / 10 * 9,
      \      'winRow': &lines / 20,
      \      'winWidth': &columns / 10 * 4,
      \    }
endfunction

autocmd FileType ddu-ff call s:ddu_ff_settings()
function! s:ddu_ff_settings() abort
  nnoremap <buffer> <CR> 
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> i
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('preview')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> v
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer> x
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'split'}})<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_settings()
function! s:ddu_filter_settings() abort
  inoremap <buffer> <CR>
        \ <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_filer_settings()
function! s:ddu_filer_settings() abort
  nnoremap <buffer> <CR> <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
  nnoremap <buffer> v
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer> x
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'split'}})<CR>
  nnoremap <buffer> <Space>
        \ <Cmd>call ddu#ui##do_action('toggleSelectItem')<CR>
  nnoremap <buffer> l
        \ <Cmd>call ddu#ui#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction

function! DDUFiles()
  call ddu#start({
        \  'sources': [{'name':'file_rec',}],
        \  'ui': 'ff',
        \  'uiParams': {
        \    'ff': g:DDUUIFFSizeConfig,
        \  },
        \  })
endfunction
command! DDUFiles :call DDUFiles()

" TODO: commonize these function as one function which requires one argument
" to determine what is the source of the fuzzy finder.
function! DDUBuffers()
  call ddu#start({
        \  'sources': [{'name': 'buffer'}],
        \  'ui': 'ff',
        \  'uiParams': {
        \    'ff': g:DDUUIFFSizeConfig,
        \  },
        \  })
endfunction
command! DDUBuffers :call DDUBuffers()

function! DDURg()
  call ddu#start({
        \  'sources':[
        \    {
        \      'name': 'rg',
        \      'params': {'input': expand('<cword>')},
        \    },
        \  ],
        \  'ui': 'ff',
        \  'uiParams': {
        \    'ff': g:DDUUIFFSizeConfig,
        \  },
        \  'volatile': v:true,
        \  })
endfunction
command! DDURg :call DDURg()

function! DDUFiler()
  call ddu#start({
        \  'ui': 'filer',
        \  'uiOptions': {
        \    'filer': {
        \      'persist': v:true,
        \    },
        \  },
        \  'uiParams': {
        \    'filer': { 
        \      'winWidth': &columns / 10, 
        \    },
        \  },
        \  'sources': [{'name': 'file'}],
        \  'sourceOptions': {'_':{'columns': ['filename'],},},
        \  })
endfunction
command! DDUFiler :call DDUFiler()
