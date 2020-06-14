" Go specific configs

setlocal noexpandtab              " Use tabs instead of spaces
nnoremap <Leader>i :GoImports<CR> " goimports is too slow to run on every save
nnoremap <Leader>b :GoBuild<CR>   " runs go build
nnoremap <Leader>e :call go#iferr#Generate()<CR>  " auto generate an if err != nil
