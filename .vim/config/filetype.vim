" common config
set autoindent " indent automatic when return
set smartindent " make nest if there is a curly bracket

augroup filetypedetect
  autocmd!
  autocmd BufRead, BufNewFile *.rb *.erb setfiletype ruby
  autocmd BufRead, BufNewFile *.py setfiletype python
  autocmd BufRead, BufNewFile *.yaml *.yml setfiletype yaml
augroup END

