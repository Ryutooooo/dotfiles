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

" Git blame
Plug 'f-person/git-blame.nvim'

let g:gitblame_enabled = 0

" resizing buffer
Plug 'simeji/winresizer'

" preview markdown
Plug 'previm/previm'
let g:previm_open_cmd = 'open -a Google\ Chrome'

" basic neovim lsp plugin
Plug 'neovim/nvim-lspconfig'

" color scheme
Plug 'Yagua/nebulous.nvim'

" enhancing syntax hightlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" for completion
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'Shougo/ddc-nvim-lsp'

Plug 'Shougo/pum.vim'

" for ddu
Plug 'Shougo/ddu.vim'
Plug 'Shougo/ddu-column-filename'
Plug 'Shougo/ddu-ui-ff'
Plug 'Shougo/ddu-ui-filer'
Plug 'Shougo/ddu-source-file'
Plug 'Shougo/ddu-source-file_rec'
Plug 'Shougo/ddu-source-action'
Plug 'Shougo/ddu-filter-matcher_substring'
Plug 'Shougo/ddu-kind-file'
Plug 'shun/ddu-source-buffer'
Plug 'shun/ddu-source-rg'

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

" insert 2 spaces instead of \t
set expandtab
" 2 spaces will be generated
set shiftwidth=2

" set wildchar
set history=500

set smartindent

" hidden cmdline
set cmdheight=0

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
runtime vim/pum.vim

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
