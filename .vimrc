syntax on
runtime! config/init/*.vim 
runtime! config/plugins/*.vim

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
" シンタックスチェックのコマンド
nnoremap <C-C> :w<CR>:SyntasticCheck<CR>

" ハイライトを消す
nnoremap <ESC><ESC> :noh<CR>

" Terminal起動
nnoremap <S-t> :terminal<CR>

" fzf keymap
let mapleader = "f"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>c :Commands<CR>


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

