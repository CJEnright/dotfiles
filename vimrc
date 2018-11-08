" Use ViM settings (not Vi)
set nocompatible

" Install vim-plug if it's not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin dealings
call plug#begin('~/.vim/plugged')
	" Lazy load nerdtree
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	"Plug 'sheerun/vim-polyglot'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-surround'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'majutsushi/tagbar'
	Plug 'vimwiki/vimwiki'
call plug#end()

"## Misc settings
set ruler " Show cursor stats in bottom left
set background=dark " Make the background dark
set confirm " Prompt when trying to quit without saving
let mapleader = " " " Use <Space> as the leader key
set spelllang=en_us,de_de " Used English and German spell checking
autocmd BufRead,BufNewFile *.md setlocal spell " Turn on spell check in md files

" ## Tab complete settings
set wildmenu
set wildmode=longest,list,full
set complete=.,b,u,]
set completeopt=menu,preview
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction

imap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable syntax highlighting
syntax enable

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Tabs and indentaion
set autoindent
set tabstop=2 " Tabs take up 2 columns
set shiftwidth=2 " Indent 2 columns with '<' and '>'
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
filetype indent on

" Show line numbers
set number

" Strip trailing whitespace
"autocmd BufWritePre * %s/\s\+$//e

" Show indentation
"set list listchars=tab:»\ ,trail:·,extends:»,precedes:«

" Rendering speed
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.
set synmaxcol=200          " Only highlight the first 200 columns.
set t_Co=256               " Use 256 bit colors

" Temporary files
" lets not have a bunch of temp files floating around everywhere
" Create temp files directory if needed
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
	call mkdir($HOME.'/.vim/files')

	" These are a bit sketch but should generally work unless you delete one
	" later
	call mkdir($HOME.'/.vim/files/backup')
	call mkdir($HOME.'/.vim/files/swap')
	call mkdir($HOME.'/.vim/files/undo')
	call mkdir($HOME.'/.vim/files/info')
endif

" Backup files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =/tmp/*,/private/tmp/*
" Swap files
set directory   =$HOME/.vim/files/swap//
set updatecount =100
" Undo files
set undofile
set undodir     =$HOME/.vim/files/undo/
" Viminfo files
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" Searching
set hlsearch " Search highlighting
set incsearch " Start searching as you type

set scrolloff=5 " Always show at least 5 lines on top or bottom 

" Jump to last line when file was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" ## Windows and tabs and such
set splitright " Open new splits to the right the current one

let g:vimwiki_list = [{'path': '~/Documents/git/notes',
			\ 'syntax': 'markdown',
			\ 'ext': '.md'}]

" ## Remappings
" ### Global mode
" Open nerdtree on ctrl n
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1

" ### Normal mode
nnoremap ; :
nnoremap <_> <Plug>Vimwiki2HTML
nnoremap <_> <Plug>Vimwiki2HTMLBrowse
nnoremap <leader>w <C-w>
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>j :w<Enter>
nnoremap <Leader>k :wq<Enter>
nmap <silent> <Leader>/ :nohlsearch<CR>
" #### FZF 
nnoremap <Leader>ff :FZF<Enter>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>ft :Tags<CR>
" #### Tagbar
nmap <C-m> :TagbarToggle<CR>
let g:tagbar_map_showproto = '<F18>'
let g:tagbar_compact = 1

" ### Insert Mode
inoremap jk <Esc>`^
inoremap fd <Esc>`^
inoremap jj <Esc>:w<CR>a


" Use relative lines in normal, absolute in insert
" WARNING: Makes scrolling with mouse wheel super slow
" ^ lol just don't use the mouse?
function! Relativize(v)
	if &number
		let &relativenumber = a:v
	endif
endfunction

augroup relativize
	autocmd!
	autocmd BufWinEnter,FocusGained,InsertLeave,WinEnter * call Relativize(1)
	autocmd BufWinLeave,FocusLost,InsertEnter,WinLeave * call Relativize(0)
augroup END


" Things I used to use but don't anymore
" ...but might want to at some point in the future

" Status line
"set laststatus=2           " Always show statusline.
"set statusline=\ %f
"set statusline+=%=         " Switch to the right side
"set statusline+=%m
"set statusline+=\ %l:     " Line numbers
"set statusline+=%v\       " Column numbers

