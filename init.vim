"================================================================
"     vim-plug config files
"================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" resizing buffer
Plug 'simeji/winresizer'

" previewing markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" basic neovim lsp plugin
Plug 'neovim/nvim-lspconfig'

" color scheme
Plug 'Yagua/nebulous.nvim'

" enhancing syntax hightlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" showing git status on vim inline
Plug 'airblade/vim-gitgutter'
" extend vim with Git
Plug 'tpope/vim-fugitive'
" for extention of GBrowse in vim-fugitive
Plug 'tpope/vim-rhubarb'

" for completion
Plug 'Shougo/ddc.vim'
" for ddc, sources
Plug 'Shougo/ddc-around'
" for ddc, filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
" for ddc & lsp
Plug 'Shougo/ddc-nvim-lsp'

" for ddu
Plug 'Shougo/ddu.vim'
Plug 'Shougo/ddu-ui-ff'
Plug 'Shougo/ddu-source-file_rec'
Plug 'Shougo/ddu-filter-matcher_substring'
Plug 'Shougo/ddu-kind-file'

" for Deno
Plug 'vim-denops/denops.vim'
Plug 'vim-denops/denops-helloworld.vim'

call plug#end()

"================================================================
"     editor
"================================================================

set number

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

" make replacing visualize
set inccommand=split

" insert 4 spaces instead of \t
set expandtab
" 4 spaces will be generated
set shiftwidth=4

"set wildchar
set history=500

set smartindent

" auto reload when moved pane
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" Load other config files
runtime vim/ddc.vim
runtime vim/ddu.vim
runtime vim/lsp.lua
runtime vim/treesitter.lua
runtime vim/keymap.vim
runtime vim/go.vim
runtime vim/colorscheme.lua
runtime vim/statusline.lua

"================================================================
"     system
"================================================================
lan mes C

set nobackup
set noswapfile
set noundofile

"================================================================
"     functions
"================================================================

set runtimepath+=~/.zplug/bin/fzf

function! FZGrep(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call FZGrep(<q-args>, <bang>0)

let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd! InsertLeave * call system(g:imeoff)
  autocmd! FocusGained * call system(g:imeoff)
endif
