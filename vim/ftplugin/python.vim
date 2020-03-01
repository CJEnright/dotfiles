if !exists("current_compiler")
  compiler pyunit 
endif

set makeprg=python3\ %

nnoremap <Leader>s :make<CR><CR>
