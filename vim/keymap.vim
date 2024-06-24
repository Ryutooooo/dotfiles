" Turn off highlight
nnoremap <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"

" List All files on DDU fuzzy finder
nnoremap <Leader>f :Ddu file_rec -ui=ff<CR>
" List buffers on DDU fuzzy finder
nnoremap <Leader>b :Ddu buffer -ui=ff<CR>
" Filer
nnoremap <Leader>n :Ddu file -ui=filer<CR>
" Search file by string under cursor
nnoremap <C-g> :DDURg<CR>
" TODO: This keymap should be replaced by ddu
nnoremap <Leader>,s :RG<CR>
" Open current buffer in GitHub
nnoremap <Leader>,gf :OpenInGHFile<CR>
" TODO: This keymap should be replaced by ddu
nnoremap <Leader>c :Commands<CR>

" Save file
nnoremap <Leader>w :w<CR>
" Close buffer
nnoremap <Leader>q :q<CR>
" Close vim
nnoremap <Leader>a :qa<CR>
" Reload vimrc
nnoremap <Leader>r :source $HOME/.config/nvim/init.vim<CR>
nnoremap <Leader>s :PrevimOpen<CR>
nnoremap <Leader>g :GitBlameToggle<CR>
" Switch tab
nnoremap <Tab> gt
" Create new tab
nnoremap <S-Tab> :tabnew<CR>
