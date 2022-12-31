"================================================================
"                       Key map
"================================================================
" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
" All file
nnoremap <Leader>f <Cmd>call ddu#start({'source': [{'name':'file_rec'}]})<CR>
" Buffer
nnoremap <Leader>b <Cmd>call ddu#start({
    \  'sources': [{'name': 'buffer'}],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false, }
    \  },
    \  })<CR>
" Search from file by string under cursor
nnoremap <C-g> <Cmd>call ddu#start({
    \  'volatile': v:true,
    \  'sources':[
    \    {'name': 'rg', 'params': {'input': expand('<cword>')}}
    \  ],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false, }
    \  },
    \  })<CR>
" nnoremap <Leader>c <Cmd>call ddu#start({
"     \  'sources': [{'name': 'actions'}],
"     \  'kindOptions': {
"     \    'action': {
"     \      'defaultAction': 'do',
"     \    },
"     \  },
"     \  })<CR>

" Filer
nnoremap <Leader>n <Cmd>call ddu#start({
    \  'ui': 'filer',
    \  'sources': [{'name': 'file', 'params': {}}],
    \  'sourceOptions': {
    \    '_': {
    \      'columns': ['filename'],
    \    },
    \  },
    \  'kindOptions': {
    \    'file': {
    \      'defaultAction': 'open',
    \    },
    \  }
    \  })<CR>

nnoremap <Leader>c :Commands<CR>

" turn on Terminal
nnoremap <Leader>t :terminal<CR>
" save file
nnoremap <Leader>w :w<CR>
" close file
nnoremap <Leader>q :q<CR>
" close vim
nnoremap <Leader>a :qa<CR>
" reload vimrc
nnoremap <Leader>r :source $HOME/.config/nvim/init.vim<CR>

nnoremap <Leader>s :PrevimOpen<CR>

nnoremap <Leader>g :GitBlameToggle<CR>

nnoremap <Tab> gt
nnoremap <S-Tab> :tabnew<CR>

" tmp
nnoremap <Leader>,s :RG<CR>
