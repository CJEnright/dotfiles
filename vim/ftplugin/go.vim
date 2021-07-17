" Go specific configs

let g:go_fmt_command='gofmt'  " Run gofmt on save, goimports was too slow

setlocal noexpandtab              " Use tabs instead of spaces
nnoremap <Leader>i :GoImports<CR> " goimports is too slow to run on every save
nnoremap <Leader>b :GoBuild<CR>   " runs go build
nnoremap <Leader>e :call go#iferr#Generate()<CR>  " auto generate an if err != nil
