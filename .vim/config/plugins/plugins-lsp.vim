"================================================================
"			lsp config
"================================================================
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

autocmd BufWritePre <buffer> LspDocumentFormatSync

" remap code jump for lsp
nmap <C-]> :LspDefinition<CR>
