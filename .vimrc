"================================================================
"			Key map
"================================================================
" turn off hightlight
nmap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>g :GFiles<CR>
nmap <Leader>c :Commands<CR>
nmap <Leader>n :NERDTreeToggle<CR>
" turn on Terminal
nmap <Leader>t :terminal<CR>
" save file
nmap <Leader>w :w<CR>
" close file
nmap <Leader>q :q<CR>
" reload vimrc
nmap <Leader>r :source ~/.vimrc<CR>
" turn on paste mode
nmap <Leader>p :set paste!<CR>

"================================================================
"			Vundle config
"================================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'
" git action
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-endwise'
Plugin 'itchyny/lightline.vim'
" incremental search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" changging buff size easier
Plugin 'simeji/winresizer'
" color scheme
Plugin 'morhetz/gruvbox'
" lsp plugin
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
" editorconfig
Plugin 'sgur/vim-editorconfig'
" golang plugin
Plugin 'fatih/vim-go'
" grep plugin
Plugin 'rking/ag.vim'
" html emmet
Plugin 'mattn/emmet-vim'
" md preview
Plugin 'MikeCoder/markdown-preview.vim'

"================================================================
"     load config files
"================================================================
runtime! config/**/*.vim
