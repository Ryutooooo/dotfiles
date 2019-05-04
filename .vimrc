syntax on
runtime config/init/*.vim 
runtime config/plugins/*.vim

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set backspace=indent,eol,start
set clipboard+=autoselect
set laststatus=2
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set wildmode=list:longest
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" ファイルの変更を移動時に読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END


"================================================================
"			Key map
"================================================================
" ハイライトを消す
nnoremap <ESC><ESC> :noh<CR>
nnoremap <S-f> :Files<CR>
nnoremap <S-t> :terminal<CR>


"================================================================
"			fzf config
"================================================================
let g:fzf_layout = { 'down': '~15%' }


"================================================================
"			NERDTree config
"================================================================
" vim起動時にファイルが指定されればNERDTreeを非表示
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


"================================================================
"		  syntastic config
"================================================================
" シンタックスチェックのコマンド
nnoremap <C-C> :w<CR>:SyntasticCheck<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']


"================================================================
"			Ruby Jump cofig
"================================================================
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  au!
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END


"================================================================
"			Vundle Plugins
"================================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" plugin
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic.git'
Bundle 'ngmy/vim-rubocop'
Bundle 'tpope/vim-endwise'
Bundle 'KeitaNakamura/railscasts.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
" ...
filetype plugin indent on     " required!

