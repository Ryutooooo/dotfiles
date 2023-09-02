-- statusline
-- %<                                             trim from here
-- %f                                             path+filename
-- %m                                             check modifi{ed,able}
-- %r                                             check readonly
-- %w                                             check preview window
-- %=                                             left/right separator
-- %l/%L,%c                                       rownumber/total,colnumber
-- %{&fileencoding?&fileencoding:&encoding}       file encoding
vim.opt.statusline = "  %< %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  "
