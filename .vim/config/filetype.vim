" common config
set autoindent " indent automatic when return
set smartindent " make nest if there is a curly bracket

augroup filetypedetect
  au BufRead, BufNewFile *.rb *.erb setfiletype ruby
  au BufRead, BufNewFile *.py setfiletype python
  au BufRead, BufNewFile *.yaml *.yml setfiletype yaml
augroup END

