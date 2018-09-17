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
	Plug 'sheerun/vim-polyglot'
	Plug 'airblade/vim-gitgutter'
call plug#end()

" Misc settings
set ruler
set title
set background=dark
let mapleader = ","

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax enable

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Tabs and indentaion
set autoindent
set tabstop=2
set shiftwidth=2
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
filetype indent on

" Sets line number based on buffer
set number

" Strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

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

set scrolloff=5 " Context while scrolling

" Jump to last line when file was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Use ; instead of :
nnoremap ; :
" Open nerdtree on ctrl n
map <C-n> :NERDTreeToggle<CR>
" Use gw for window switchting
map gw <C-w>

" Hit ,/ to clear search highlighting
nmap <silent> ,/ :nohlsearch<CR>
" Hit hh in insert mode to open nerdtree
inoremap hh <Esc>:NERDTreeToggle<CR>
" Hit j then k for esc, `^ means dont go back a char
inoremap jk <Esc>`^
" Hit k then j for wq
inoremap kj <Esc>:wq<Enter>
" Hit j then j to save in insert mode
inoremap jj <Esc>:w<CR>a
" Hit d then f to tab
inoremap df <Tab>


" Things I used to use but don't anymore

" Use relative lines in normal, absoulte in insert
" Makes scrolling super slow
"function! Relativize(v)
"	if &number
"		let &relativenumber = a:v
"	endif
"endfunction

"augroup relativize
"	autocmd!
"	autocmd BufWinEnter,FocusGained,InsertLeave,WinEnter * call Relativize(1)
"	autocmd BufWinLeave,FocusLost,InsertEnter,WinLeave * call Relativize(0)
"augroup END


" Status line
"set laststatus=2           " Always show statusline.
"set statusline=\ %f
"set statusline+=%=         " Switch to the right side
"set statusline+=%m
"set statusline+=\ %l:     " Line numbers
"set statusline+=%v\       " Column numbers


