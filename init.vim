"================================================================
"     vim-plug config files
"================================================================

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" color scheme

" statusline
Plug 'itchyny/lightline.vim'

Plug 'projekt0n/github-nvim-theme'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
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

" for Deno
Plug 'vim-denops/denops.vim'
Plug 'vim-denops/denops-helloworld.vim'

call plug#end()

" Load other config files
runtime vim/ddc.vim
runtime vim/keymap.vim
runtime vim/colorscheme.lua
runtime vim/statusline.lua

"================================================================
"     system
"================================================================

set langmenu=en_US.UTF-8
language messages en_US.UTF-8

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac

" no backup no swap
set nobackup
set noswapfile

"================================================================
"     editor
"================================================================

set number
set t_Co=256

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

" auto reload when moved pane
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

"================================================================
"     vim-plug config files
"================================================================

" lightline
set laststatus=2

" NERDTree config
" default preview hidden file
let NERDTreeShowHidden=1

" vim-gitgutter
let g:gitgutter_highlight_lines = 1

lua << EOF
require'lspconfig'.pyright.setup{}
local on_attach = function (client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
    require('completion').on_attach(client)
end
require('lspconfig').gopls.setup({on_attach = on_attach})
require('lspconfig').pyright.setup({on_attach = on_attach})
require('lspconfig').tsserver.setup({on_attach = on_attach})
require('lspconfig').vimls.setup({on_attach = on_attach})
require('lspconfig').intelephense.setup({on_attach = on_attach})
require('lspconfig').dartls.setup({on_attach = on_attach})
EOF

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
