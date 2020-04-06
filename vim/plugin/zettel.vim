if exists("g:loaded_zettel")
  finish
endif
let g:loaded_zettel = 1

function! zettel#prompt_new()
  call inputsave()
  let name = input('Note name: ')
  call inputrestore()

  call zettel#new(name)
endfunction

function! zettel#new(name)
  let timestamp = systemlist('date +\%s')[0]
  let fname = tolower(substitute(a:name, ' ', '_', 'g') . '_' . timestamp . '.md')
  let fpath = g:zettel_dir . '/' . fname

  let fcontents = substitute(g:zettel_template, '%Title', a:name, 'g')
  let fcontents = substitute(g:zettel_template, '%Title_link', '[' . a:name . '](' . fname . ')', 'g')

  let noop=system('echo "' . fcontents . '" >> ' . fpath)
  execute 'edit ' . fpath
endfunction
