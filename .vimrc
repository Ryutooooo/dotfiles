runtime! config/init/*.vim 
runtime! config/plugins/*.vim

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
let mapleader = "\<S-f>"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>c :Commands<CR>

"================================================================
"			Vundle config
"================================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic.git'
Bundle 'ngmy/vim-rubocop'
Bundle 'tpope/vim-endwise'
Bundle 'KeitaNakamura/railscasts.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
filetype plugin indent on     " required!

