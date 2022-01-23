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

nnoremap <Leader>s :MarkdownPreviewToggle<CR>

nnoremap <Leader>,s :RG<CR>
nnoremap <Leader>,l :GBrowse<CR>

nnoremap <Tab> gt
nnoremap <S-Tab> :tabnew<CR>

nnoremap <C-g> :Rg <C-R>=expand('<cword>')<CR><CR>
