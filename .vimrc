syntax on
colorscheme railscasts

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" バックスペースを使えるようにする
set backspace=indent,eol,start
" ビジュアルモードで選択したテキストがクリップボードに入るようにする。
:set clipboard+=autoselect

" ステータスライン
let g:lightline = {}
set laststatus=2

" 見た目系
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインの補完
set wildmode=list:longest

" Tab系
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

" ハイライトを消す
nnoremap <ESC><ESC> :noh<CR>

" ファイルの変更を移動時に読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" rubocop config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers=['rubocop']
nnoremap <C-C> :w<CR>:SyntasticCheck<CR>

" jump somecondition in .ruby file
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  au!
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

" vundler config
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" plugin
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic.git'
Bundle 'ngmy/vim-rubocop'
Bundle 'tpope/vim-endwise'
Bundle 'KeitaNakamura/railscasts.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'codeape2/vim-multiple-monitors'
" ...
filetype plugin indent on     " required!
