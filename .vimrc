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
" close vim 
nmap <Leader>a :qa<CR>
" reload vimrc
nmap <Leader>r :source ~/.vimrc<CR>
" turn on paste mode
nmap <Leader>p :set paste!<CR>

nmap <Tab> gt
nmap <S-Tab> :tabnew<CR>
nmap <C-g> :Rg <C-R>=expand('<cword>')<CR><CR>

nmap <C-s> <Plug>MarkdownPreviewToggle

set nocompatible

"================================================================
"     vim-plug config files
"================================================================
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/FuzzyFinder'

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
Plug 'shinchu/lightline-gruvbox.vim'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" statusline
Plug 'itchyny/lightline.vim'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" ag for vim
Plug 'rking/ag.vim'

" emmet
Plug 'mattn/emmet-vim'

" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" CSV formatter
Plug 'chrisbra/csv.vim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Initialize plugin system
call plug#end()

"================================================================
"     load config files
"================================================================
runtime! config/**/*.vim
