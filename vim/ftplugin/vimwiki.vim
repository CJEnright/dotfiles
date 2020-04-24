" So this is really markdown but vimwiki calls it vimwiki so w/e
" I should probably just yeet vimwiki at some point...

function! vimwiki#pandocRender()
  execute 'silent !pandoc ' . expand('%:p') . ' -o ' . expand('%:r') . '.pdf &'
endfunction

function! vimwiki#toggleLatexRender()
  if !exists('#LatexAugroup#BufWritePost')
    augroup LatexAugroup
      autocmd!
      autocmd BufWritePost * call vimwiki#pandocRender()
    augroup END
  else
    augroup LatexAugroup
      autocmd!
    augroup END
  endif
endfunction

function! vimwiki#openPDFIfExists()
  " TODO this is mac only rn
  execute 'silent !open ' . expand('%:r') . '.pdf'
endfunction

nnoremap <Leader>l :call vimwiki#toggleLatexRender()<CR>
nnoremap <Leader>o :call vimwiki#openPDFIfExists()<CR>
