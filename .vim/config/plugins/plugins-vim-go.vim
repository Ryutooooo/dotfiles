"================================================================
"			vim-go config
"================================================================
let mapleader = "\<Space>"

au Filetype go nmap <leader>s <Plug>(go-def-split)
au Filetype go nmap <leader>v <Plug>(go-def-vertical)

let g:go_fmt_command = "goimports"

let g:go_term_mode = 'split'

let g:go_template_autocreate = 0

" set breakpoint with ;d
autocmd FileType go nmap <silent> ;d :GoDebugBreakpoint<CR>
" continue debug with ;c
autocmd FileType go nmap <silent> ;c :GoDebugContinue<CR>
