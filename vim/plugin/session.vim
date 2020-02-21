if exists("g:loaded_session")
  finish
endif
let g:loaded_session = 1

" Mac and Linux have different md5 functions, figure out which to use
if executable('md5')
  let s:md5 = 'md5'
elseif executable('md5sum')
  let s:md5 = 'md5sum'
else
  echo 'couldn\'t find an md5 command, giving up'
  finish
endif

function! session#save() abort
  if exists("g:NERDTree")
    :NERDTreeClose
  endif

  if stridx(bufname(), ".git/COMMIT_EDITMSG") != -1
    return
  endif

  let fname = g:session_dir . '/' . getcwd() . '/Session.vim'
  let hash = systemlist(s:md5 . ' -qs ' . fname)[0]
  let args = g:session_dir . '/' . hash . '.vim'
  execute 'mksession!' . args

  let noop=system('echo "\" __sess_dir='. getcwd() . '" >> ' . args)
endfunction

function! session#load(dir) abort
  let fname = g:session_dir . '/' . a:dir . '/Session.vim'
  let hash = systemlist(s:md5 . ' -qs ' . fname)[0]
  let fname = g:session_dir . '/' . hash . '.vim'

  try
    if filewritable(fname) && getfsize(fname) > 0
      execute 'source ' . fname
    endif
  catch
    call inputsave()
    echo 'Failed to open session, [I]gnore  or [D]elete it?'
    let choice=nr2char(getchar())
    call inputrestore()
    if choice ==# 'd'
      call delete(fname)
    endif
  endtry
  
  echo ""
endfunction

function! session#auto_load() abort
  session#load(getcwd())
endfunction

function! session#dir_has_session(dir) abort
  let fname = g:session_dir . '/' . a:dir . '/Session.vim'
  let hash = systemlist(s:md5 . ' -qs ' . fname)[0]
  let fname = g:session_dir . '/' . hash . '.vim'

  return filereadable(fname)
endfunction

function! session#get_n_most_recent(n) abort
  let files=systemlist('ls -t ' . g:session_dir . ' | head -' . a:n)
  let ret = []
  let i = 0
  for i in files
    call add(ret, trim(systemlist('grep __sess_dir= ' . g:session_dir . '/' . i . ' | cut -c 14-')[-1]))
  endfor
  return ret
endfunction

augroup session
  autocmd!
  autocmd VimLeavePre * exe session#save()
  " So NERDTree sucks and doesn't like saving to sessions
  " So... can't autosave
  " TODO use _ANYTHING_ but NERDTree
  "autocmd BufEnter    * exe session#save()
augroup END

