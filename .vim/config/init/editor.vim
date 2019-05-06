syntax on

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
set laststatus=2
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set wildmode=list:longest
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set number

" ファイルの変更を移動時に読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
