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


set nocompatible
" git action
"Plugin 'FuzzyFinder'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'tpope/vim-endwise'
" incremental search
"Plugin 'junegunn/fzf'
"Plugin 'junegunn/fzf.vim'
" lsp plugin
"Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/asyncomplete.vim'
"Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'mattn/vim-lsp-settings'
" golang plugin
"Plugin 'fatih/vim-go'
" grep plugin
"Plugin 'rking/ag.vim'
" html emmet
"Plugin 'mattn/emmet-vim'
" md preview
"Plugin 'MikeCoder/markdown-preview.vim'
" pyhton
"Plugin 'vim-python/python-syntax'
" javascript
"Plugin 'othree/yajs.vim'


"================================================================
"     vim-plug config files
"================================================================
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
" git stuff in vim
Plug 'tpope/vim-fugitive'

" incremental search commands
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" l9 provides some utility functions
Plug 'vim-scripts/L9'

" change buffer size
Plug 'simeji/winresizer'

" source tree
Plug 'scrooloose/nerdtree'

" editorconfig
Plug 'sgur/vim-editorconfig'

" color scheme
Plug 'morhetz/gruvbox'

" markdown preview
Plug 'previm/previm'

" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'


" Initialize plugin system
call plug#end()


"================================================================
"     load config files
"================================================================
runtime! config/**/*.vim
