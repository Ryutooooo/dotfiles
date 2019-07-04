"================================================================
"     load config files
"================================================================
runtime! config/init/*.vim 
runtime! config/plugins/*.vim

"================================================================
"			Function
"================================================================
" reload!
command Reload :source ~/.vimrc

"================================================================
"			Key map
"================================================================
"NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

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
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic.git'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-endwise'
Plugin 'KeitaNakamura/railscasts.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'othree/yajs.vim'
Plugin 'maxmellon/vim-jsx-pretty'
filetype plugin indent on     " required!

