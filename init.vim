" TODO: need to make it variable 
let g:denops#deno = '/Users/ryutooooo/.deno/bin/deno'

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

" for Deno
Plug 'vim-denops/denops.vim'

" Git blame
Plug 'f-person/git-blame.nvim'

" Resize buffer
Plug 'simeji/winresizer'

" Preview markdown
Plug 'previm/previm'
let g:previm_open_cmd = 'open -a Arc'
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/dotfiles/vim/previm/markdown.css'

" Open a buffer in GitHub
Plug 'almo7aya/openingh.nvim'

" basic neovim lsp plugin
Plug 'neovim/nvim-lspconfig'

" Install manager for LSP, DAP, linters, fomatters 
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" color scheme
Plug 'rebelot/kanagawa.nvim'

" enhancing syntax hightlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" GitHub copilot
Plug 'github/copilot.vim'

" ddc
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddu-commands.vim'
Plug 'Shougo/ddc-source-around'
Plug 'Shougo/ddu-source-line'
Plug 'uga-rosa/ddc-source-lsp-setup'
Plug 'Shougo/ddc-source-lsp'
Plug 'Shougo/ddc-filter-matcher_head'
Plug 'Shougo/ddc-filter-sorter_rank'
Plug 'Shougo/ddc-ui-pum'
Plug 'uga-rosa/ddc-previewer-floating'

Plug 'Shougo/pum.vim'

" ddu 
Plug 'Shougo/ddu.vim'
Plug 'ryota2357/ddu-column-icon_filename'
Plug 'Shougo/ddu-column-filename'
Plug 'yuki-yano/ddu-filter-fzf'
Plug 'Shougo/ddu-filter-matcher_substring'
Plug 'Shougo/ddu-filter-sorter_alpha'
Plug 'Shougo/ddu-kind-file'
Plug 'Shougo/ddu-source-file'
Plug 'Shougo/ddu-source-file_rec'
Plug 'shun/ddu-source-buffer'
Plug 'shun/ddu-source-rg'
Plug 'Shougo/ddu-ui-ff'
Plug 'Shougo/ddu-ui-filer'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

lua << EOF
require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}
EOF

colorscheme kanagawa-wave
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

" disable unnecessary statusline
set laststatus=3
" auto reload when moved pane
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" Load other config files
runtime vim/ddc.vim
runtime vim/ddu.vim
runtime vim/go.vim
runtime vim/keymap.vim
runtime vim/pum.vim
runtime vim/nvim-dap.lua
runtime vim/treesitter.lua
runtime vim/statusline.lua
runtime vim/lsp.lua

autocmd BufNewFile,BufRead *.dig set filetype=yaml
autocmd Syntax yaml setl indentkeys-=<:>

" for Golang
au FileType go setlocal sw=4 ts=4 sts=4 noet
" au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4

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
