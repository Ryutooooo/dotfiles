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
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-endwise'
Plugin 'itchyny/lightline.vim'
" incremental search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" auto lint tool
Plugin 'w0rp/ale'
" changging buff size easier
Plugin 'simeji/winresizer'
" golang plugin
Plugin 'fatih/vim-go'
" color scheme
Plugin 'morhetz/gruvbox'
" compelation
Plugin 'ycm-core/YouCompleteMe'
" lsp plugin
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
filetype plugin indent on     " required!

"================================================================
"     load config files
"================================================================
runtime! config/**/*.vim
