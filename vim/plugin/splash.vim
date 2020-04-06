if exists("g:loaded_splash")
  finish
endif
let g:loaded_splash = 1

function! splash#splash()
  enew

  setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
        \ nospell

  call append(0, '')

  nnoremap <buffer><silent> w :VimwikiIndex<CR>

  nnoremap <buffer><silent> a :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> n :enew<CR>

  map <buffer> <C-n> :enew <bar> :NERDTreeToggle<CR>

  setlocal nomodifiable nomodified
endfunction
