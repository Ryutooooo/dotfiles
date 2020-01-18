"================================================================
"			lsp config
"================================================================
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

autocmd BufWritePre <buffer> LspDocumentFormatSync

" remap code jump for lsp
nmap <C-]> :LspDefinition<CR>

" ruby config
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif
