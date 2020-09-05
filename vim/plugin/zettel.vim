" Make sure we only load the plugin once
if exists("g:loaded_zettel")
  finish
endif
let g:loaded_zettel = 1

let s:zettel_template = '# %TitleLink\n
      \\n
      \## Notes\n
      \\n
      \\n
      \\n
      \\n
      \\n
      \## Backlinks\n
      \\n
      \## Tags'

function! zettel#prompt_new()
  call inputsave()
  let name = input('Note name: ')
  call inputrestore()

  call zettel#new(name)
endfunction

" Create a new zettel entry. Resulting file will be the lower case name with
" spaces converted to underscores, and a timestamp added.
"
" Supported substitutions:
" * %Title - Substituted with the name passed
" * %TitleLink - Substituted with a link to the entry
function! zettel#new(name)
  let timestamp = systemlist('date +\%s')[0]
  let fname = tolower(substitute(a:name, ' ', '_', 'g') . '_' . timestamp . '.md')
  let fpath = g:zettel_dir . '/' . fname

  let fcontents = substitute(s:zettel_template, '%TitleLink', '[' . a:name . '](' . fname . ')', 'g')

  call system('echo "' . fcontents . '" >> ' . fpath)
  execute 'edit ' . fpath
endfunction

" Cleanup the results of an fzf search and insert
function! zettel#insert(raw_name)
  let file_name = substitute(a:raw_name, '\v(.{-}):\d+:.*$', '\1', '')
  let link = system('head -1 "' . file_name . '" | cut -c3-')
  execute "normal! i" . link . "\<Esc>"
endfunction

" Search for an entry by its content, then insert it into the current buffer
function! zettel#grep_and_insert()
  call fzf#run(fzf#wrap({'sink': function('zettel#insert'), 'source': 'rg --column --no-heading --color=never --smart-case "\S" ' . g:zettel_dir}))
endfunction
