" call ddu#custom#patch_global({'profile': v:true})

call ddu#custom#alias('column', 'icon_filename_for_ff', 'icon_filename')

call ddu#custom#patch_global(#{
      \  columnParams: #{
      \    icon_filename: #{
      \      defaultIcon: #{ icon: ' ' },
      \    },
      \    icon_filename_for_ff: #{
      \      defaultIcon: #{ icon: ' ' },
      \      padding: 1,
      \      pathDisplayOption: 'relative'
      \    }
      \  },
      \  kindOptions: #{
      \    file: #{ defaultAction: 'open' },
      \    lsp_codeAction: #{ defaultAction: 'apply' },
      \  },
      \  sourceOptions: #{
      \    _: #{
      \      ignoreCase: v:true,
      \      matchers: ['matcher_fzf'],
      \      sorters: ['sorter_fzf'],
      \    },
      \    file: #{
      \      columns: ['icon_filename']
      \    },
      \    file_rec: #{
      \      columns: ['icon_filename_for_ff']
      \    },
      \  },
      \  sourceParams: {
      \    'rg' : {
      \      'args': ['--column', '--no-heading'],
      \    },
      \    'file_rec': {
      \      'ignoredDirectories': ['.git', 'node_modules', 'vendor', '.venv'],
      \    },
      \  },
      \  uiOptions: #{filer: #{persist: v:true}},
      \  uiParams: #{
      \    ff: #{
      \      autoAction: {'name': 'preview'},
      \      floatingBorder: "single",
      \      previewFloating: v:true,
      \      previewFloatingBorder: "single",
      \      previewSplit: "vertical",
      \      split: "floating",
      \      startAutoAction: v:true,
      \    },
      \    filer: #{
      \      sort: 'filename',
      \      split: 'vertical',
      \      splitDirection: 'topleft',
      \      winWidth: &columns / 7, 
      \    },
      \  },
      \  })

autocmd VimEnter,VimResized * call SetDDUUISize()

function! SetDDUUISize()
let s:DDUUIFFSizeConfig = #{ 
      \    previewCol: &columns / 2,
      \    previewHeight: &lines / 10 * 9,
      \    previewWidth: &columns / 10 * 4,
      \    winCol: &columns / 10 * 1,
      \    winHeight: &lines / 10 * 9,
      \    winRow: &lines / 20,
      \    winWidth: &columns / 10 * 4,
      \  }
call ddu#custom#patch_global(#{
      \ uiParams: #{
      \    ff: s:DDUUIFFSizeConfig,
      \  },
      \  })
endfunction

function! DoDefaultAction()
  call ddu#ui#do_action('itemAction')
endfunction

function! OpenVsplit()
  call ddu#ui#do_action('itemAction', #{name: 'open', params: #{command: 'vsplit'}})
endfunction

function! OpenSplit()
  call ddu#ui#do_action('itemAction', #{name: 'open', params: #{command: 'split'}})
endfunction

" Fuzzy Finder
autocmd FileType ddu-ff call s:ddu_ff_settings()
function! s:ddu_ff_settings() abort
  nnoremap <buffer> <CR> <Cmd>call DoDefaultAction()<CR>
  nnoremap <buffer> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer> p <Cmd>call ddu#ui#do_action('preview')<CR>
  nnoremap <buffer> q <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> v <Cmd>call OpenVsplit()<CR>
  nnoremap <buffer> x <Cmd>call OpenSplit()<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_settings()
function! s:ddu_filter_settings() abort
  inoremap <buffer> <CR> <Esc> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
endfunction

function! DDURg()
  call ddu#start(#{
        \  sources:[#{name: 'rg', params: #{input: expand('<cword>')}}],
        \  ui: 'ff',
        \  uiParams: #{
        \    ff: s:DDUUIFFSizeConfig,
        \  },
        \  })
endfunction
command! DDURg :call DDURg()

function! DDULines()
  :Ddu line -ui=ff
endfunction
command! DDULines :call DDULines()

" Filer
autocmd FileType ddu-filer call s:ddu_filer_settings()
function! s:ddu_filer_settings() abort
  nnoremap <buffer> <CR> <Cmd>call DoDefaultAction()<CR>
  nnoremap <buffer> r <Cmd>call ddu#ui#do_action('rename')<CR>
  nnoremap <buffer> v <Cmd>call OpenVsplit()<CR>
  nnoremap <buffer> x <Cmd>call OpenSplit()<CR>
  nnoremap <buffer> l <Cmd>call ddu#ui#do_action('expandItem', #{mode: 'toggle'})<CR>
  nnoremap <buffer> q <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction
