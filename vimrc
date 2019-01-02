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
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-surround'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'majutsushi/tagbar'
	Plug 'vimwiki/vimwiki'
call plug#end()

" Misc settings
set ruler                 " Show cursor stats in bottom left
set background=dark       " Make the background dark
set confirm               " Prompt when trying to quit without saving
let mapleader = " "       " Use <Space> as the leader key
set spelllang=en_us,de_de " Used English and German spell checking
set autoread
set autowrite
set fillchars=vert:\      " Don't put characters in split divider
set cursorline            " Highlight line cursor is on
hi CursorLine cterm=NONE ctermbg=240
autocmd BufRead,BufNewFile *.md setlocal spell " Turn on spell check in md files

" Tab complete settings
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

" Make backspace behave in a sane manner
set backspace=indent,eol,start

" Disable syntax highlighting
syntax off

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Tabs and indentaion
set autoindent
set tabstop=2 " Tabs take up 2 columns
set shiftwidth=2 " Indent 2 columns with '<' and '>'
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
filetype indent on

" Rendering speed
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.
"set synmaxcol=200          " Only highlight the first 200 columns.
"set t_Co=256               " Use 256 bit colors

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
set hlsearch   " Search highlighting
set incsearch  " Start searching as you type
set ignorecase " Ignore case
set smartcase  " Only use case when search has capitals

set scrolloff=5 " Always show at least 5 lines on top or bottom 

" Jump to last line when file was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" ## Windows and tabs and such
set splitright " Open new splits to the right of the current one

let g:vimwiki_list = [{'path': '~/Documents/git/notes',
			\ 'syntax': 'markdown',
			\ 'ext': '.md'}]

let g:go_fmt_command = "goimports"
let NERDTreeShowHidden=1

" ## Remappings
" ### Global mode
map <C-n> ;NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeIgnore = ['.DS_Store', 'tags', 'tags.lock']

" ### Normal mode
nnoremap ; :
nnoremap : ;
nnoremap <_> <Plug>Vimwiki2HTML
nnoremap <_> <Plug>Vimwiki2HTMLBrowse
nnoremap <leader>w <C-w>
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>j :w<Enter>
nnoremap <Leader>k :wq<Enter>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" #### vim go
nnoremap <Leader>s :GoBuild<Enter>
nnoremap <Leader>t :GoTest<Enter>
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
