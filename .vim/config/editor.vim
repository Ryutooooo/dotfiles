filetype plugin indent on

" Setting dark mode
set background=dark    
syntax on
colorscheme gruvbox

set ambiwidth=double

set number
set t_Co=256
set autoread
set hidden
set showcmd
set backspace=indent,eol,start
" copy os clipboard
set clipboard+=unnamed
set virtualedit=onemore
set showmatch
set wildmode=list:longest
set wrapscan

set incsearch
set ignorecase
set smartcase
set hlsearch

" insert 4 spaces instead of \t
set expandtab
" 4 spaces will be generated
set shiftwidth=4

"set wildchar
set history=500

set smartindent

au FileType go setlocal sw=4 ts=4 noet

" auto reload when moved pane
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

let g:python_highlight_all = 1

" let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
" set ttimeoutlen=1
" augroup IME
"   autocmd!
"   autocmd InsertLeave * :call system(g:imeoff)
" augroup END
