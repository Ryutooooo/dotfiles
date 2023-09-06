"================================================================
"                       Key map
"================================================================
" turn off hightlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
" List All files on DDU fuzzy finder
nnoremap <Leader>f :DDUFiles<CR>
" List buffers on DDU fuzzy finder
nnoremap <Leader>b :DDUBuffers<CR>
" Filer
nnoremap <Leader>n :DDUFiler<CR>
" Search file by string under cursor
nnoremap <C-g> :DDURg<CR>
" TODO: This keymap should be replaced by ddu
nnoremap <Leader>,s :RG<CR>

" Open current buffer in GitHub
nnoremap <Leader>,gf :OpenInGHFile<CR>

nnoremap <Leader>c :Commands<CR>

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

nnoremap <Leader>s :PrevimOpen<CR>

nnoremap <Leader>g :GitBlameToggle<CR>

nnoremap <Tab> gt
nnoremap <S-Tab> :tabnew<CR>

