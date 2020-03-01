if exists("g:loaded_splash")
  finish
endif
let g:loaded_splash = 1

" Easy to reach keys
let s:keys = ['j', 'k', 'f', 'd', 's', 'h', 'g', 'n']

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

  let files = session#get_n_most_recent(len(s:keys))
  let ln = 1

  if len(files)
    if session#dir_has_session(getcwd())
      call append(ln, '  Local session:')
      let ln += 1
      call append(ln, '    [l]' . fnamemodify(getcwd(), ":~:."))
      let ln += 1
      let args = '<buffer><silent> l :enew <bar> :call session#load("' . getcwd() . '")<CR><CR>'
      execute 'nnoremap' . args
      call append(ln, ' ')
      let ln += 1
    endif

    call append(ln, '  Recent sessions:')
    let ln += 1

    let inc = 0
    for i in files
      call append(ln, '    [' . s:keys[inc] . '] ' . fnamemodify(i, ":~:."))
      let args = '<buffer><silent> ' . s:keys[inc] . ' :enew <bar> :call session#load("' . i . '") <bar> :call system("cd ' . i . '")<CR><CR>'
      execute 'nnoremap' . args
      let inc += 1
      let ln += 1
    endfor
  endif

  call append(ln, '')
  let ln += 1
  call append(ln, '')
  let ln += 1
  call append(ln, '    [w] ' . fnamemodify("~/Code/notes/index.md", ":~:."))
  let ln += 1
  nnoremap <buffer><silent> w :VimwikiIndex<CR>

  nnoremap <buffer><silent> a :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> n :enew<CR>

  map <buffer> <C-n> :enew <bar> :NERDTreeToggle<CR>

  setlocal nomodifiable nomodified
endfunction
