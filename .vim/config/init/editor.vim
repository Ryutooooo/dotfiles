syntax on
colorscheme railscasts

set number
set t_Co=256
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
set virtualedit=onemore
set showmatch
set wildmode=list:longest
set shiftwidth=2
set wrapscan

set tabstop=2
set expandtab
set smartindent
set shiftwidth=4

set incsearch
set ignorecase
set smartcase
set hlsearch

set wildmenu
set history=500

" ファイルの変更を移動時に読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
