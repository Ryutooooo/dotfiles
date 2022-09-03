"================================================================
"                       Key map
"================================================================
" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
" nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f <Cmd>call ddu#start({'source': [{'name':'file_rec'}]})<CR>
nnoremap <Leader>b <Cmd>call ddu#start({
    \  'sources': [{'name': 'buffer'}],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false, }
    \  },
    \  })<CR>
nnoremap <Leader>c :Commands<CR>
" nnoremap <Leader>c <Cmd>call ddu#start({
"     \  'sources': [{'name': 'actions'}],
"     \  'kindOptions': {
"     \    'action': {
"     \      'defaultAction': 'do',
"     \    },
"     \  },
"     \  })<CR>

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

nnoremap <Leader>s :MarkdownPreviewToggle<CR>

nnoremap <Leader>g :GitBlameToggle<CR>

nnoremap <Leader>,s :RG<CR>
nnoremap <Leader>,l :GBrowse<CR>

nnoremap <Tab> gt
nnoremap <S-Tab> :tabnew<CR>

nnoremap <C-g> <Cmd>call ddu#start({
    \  'name': 'grep',
    \  'sources':[
    \    {'name': 'rg', 'params': {'input': expand('<cword>')}}
    \  ],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false, }
    \  },
    \  })<CR>
