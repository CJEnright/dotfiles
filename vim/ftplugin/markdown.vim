function! markdown#pandocRender()
  execute 'silent !pandoc ' . expand('%:p') . ' -o ' . expand('%:r') . '.pdf &'
endfunction

function! markdown#toggleLatexRender()
  if !exists('#LatexAugroup#BufWritePost')
    augroup LatexAugroup
      autocmd!
      autocmd BufWritePost * call markdown#pandocRender()
    augroup END
  else
    augroup LatexAugroup
      autocmd!
    augroup END
  endif
endfunction

function! markdown#openPDFIfExists()
  " TODO this is mac only rn
  execute 'silent !open ' . expand('%:r') . '.pdf'
endfunction

nnoremap <Leader>l :call markdown#toggleLatexRender()<CR>
nnoremap <Leader>o :call markdown#openPDFIfExists()<CR>
