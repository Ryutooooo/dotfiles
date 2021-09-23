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

Plug 'simeji/winresizer'

Plug 'scrooloose/nerdtree'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" color scheme
Plug 'nanotech/jellybeans.vim'

" statusline
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

call plug#end()

"================================================================
"                       Key map
"================================================================
" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>c :Commands<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
" turn on Terminal
nnoremap <Leader>t :terminal<CR>
" save file
nnoremap <Leader>w :w<CR>
" close file
nnoremap <Leader>q :q<CR>
" close vim
nnoremap <Leader>a :qa<CR>
" reload vimrc
nnoremap <Leader>r :source $HOME/.config/nvim/init.vim<CR>
" turn on paste mode
nnoremap <Leader>p :set paste!<CR>


nnoremap <Tab> gt
nnoremap <S-Tab> :tabnew<CR>
nnoremap <Leader>,s :RG<CR>
nnoremap <Leader>,l :GBrowse<CR>
nnoremap <C-g> :Rg <C-R>=expand('<cword>')<CR><CR>

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

colorscheme jellybeans

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
let g:lightline = {'component': {'filename': '%f'}}
let g:lightline.colorscheme = 'jellybeans'

" NERDTree config
" default preview hidden file
let NERDTreeShowHidden=1

" vim-gitgutter
let g:gitgutter_highlight_lines = 1

" completion-nvim
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:vimsyn_embed='lPr'

lua << EOF
    local on_attach = function (client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
        require('completion').on_attach(client)
    end
    require('lspconfig').vimls.setup({on_attach = on_attach})
    require('lspconfig').tsserver.setup({on_attach = on_attach})
    require('lspconfig').intelephense.setup({on_attach = on_attach})
EOF

" lsp
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "false"},
        \ 'whitelist': ['ruby'],
        \ })
endif

lua << EOF
require'lspconfig'.pyright.setup{}
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
