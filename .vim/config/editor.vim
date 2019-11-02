syntax on
colorscheme railscasts

filetype plugin indent on

set number
set t_Co=256
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set backspace=indent,eol,start
set clipboard+=unnamed
set virtualedit=onemore
set showmatch
set wildmode=list:longest
set wrapscan

set incsearch
set ignorecase
set smartcase
set hlsearch

set wildmenu
set history=500

set noshowmode

" ファイルの変更を移動時に読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END