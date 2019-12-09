"================================================================
"     load config files
"================================================================
runtime! config/**/*.vim

"================================================================
"			Function
"================================================================
" reload!
command Reload :source ~/.vimrc

"================================================================
"			Key map
"================================================================
" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

" turn on Terminal
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
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-endwise'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'w0rp/ale'
Plugin 'simeji/winresizer'
Plugin 'fatih/vim-go'
Plugin 'soramugi/auto-ctags.vim'
filetype plugin indent on     " required!

