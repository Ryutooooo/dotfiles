"================================================================
"			NERDTree config
"================================================================
" vim起動時にファイルが指定されればNERDTreeを非表示
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
