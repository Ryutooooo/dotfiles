"================================================================
"                       Key map
"================================================================
" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"

" All file
nnoremap <Leader>f <Cmd>call ddu#start({
    \  'sources': [{'name':'file_rec'}],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false }
    \  },
    \  })<CR>

" Buffer
nnoremap <Leader>b <Cmd>call ddu#start({
    \  'sources': [{'name': 'buffer'}],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false }
    \  },
    \  })<CR>

" Search file by string under cursor
nnoremap <C-g> <Cmd>call ddu#start({
    \  'sources':[
    \    {
    \      'name': 'rg',
    \      'params': {'input': expand('<cword>')},
    \    },
    \  ],
    \  'uiParams': {
    \    'ff': { 'startFilter': v:false }
    \  },
    \  'volatile': v:true,
    \  })<CR>

" Filer
nnoremap <Leader>n <Cmd>call ddu#start({
    \  'ui': 'filer',
    \  'sources': [{'name': 'file'}],
    \  'sourceOptions': {'_':{'columns': ['filename'],},},
    \  })<CR>

" TODO: This keymap should be replaced by ddu
nnoremap <Leader>,s :RG<CR>

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

