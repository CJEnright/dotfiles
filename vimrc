" Use ViM settings (not Vi)
set nocompatible

" Install vim-plug if it's not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-surround'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'majutsushi/tagbar'
	Plug 'vimwiki/vimwiki'
call plug#end()

" Filetype detection
filetype on         " Enable detecting filetype
filetype plugin on  " Load plugin file (if there is one) for this filetype
filetype indent on  " Use language dependent indenting

au! FileType css,scss setl iskeyword+=- " Make hypens part of words in CSS files

" Miscellaneous settings
set ruler                       " Show cursor stats in bottom left
set confirm                     " Prompt when trying to quit without saving
set autoread                    " Automatically read files
set autowrite                   " Automatically write files
set splitright                  " Open new splits to the right of the current one
set scrolloff=5                 " Always show at least 5 lines on top or bottom 
set fillchars=vert:\            " Don't put characters in split divider
set backspace=indent,eol,start  " Make backspace like a normal editor

" Searching
set hlsearch   " Search highlighting
set incsearch  " Start searching as you type
set ignorecase " Ignore case
set smartcase  " Only use case when search has capitals

" Tabs and indentaion
set autoindent    " Copy indention on new line
set tabstop=2     " Tabs take up 2 columns
set shiftwidth=2  " Indent 2 columns with '<' and '>'
set shiftround    " Use multiple of shiftwidth when indenting with '<' and '>'

" Rendering speed
set ttyfast     " Faster redrawing.
set lazyredraw  " Only redraw when necessary.

" Colors
syntax on                             " Enable syntax highlighting
set background=dark                   " Use a dark background
set cursorline                        " Highlight line cursor is on
hi CursorLine cterm=NONE ctermbg=240  " Set cursorline color to light grey
hi clear SpellBad                     " Reset spell checker color
hi SpellBad cterm=underline           " Underline misspelled words

" Spell checking
set spelllang=en_us,de_de                       " Use English and German spell checking
autocmd BufRead,BufNewFile *.md setlocal spell  " Turn on spell check in md files

" Tab complete settings
set wildmenu  " Enable command line completions
" wildmode defines how to show completions
" longest:full  Show wildmenu with completions
" full          Complete to next full match, wrap around at end
set wildmode=longest:full,full
" complete defines where to look for possible completions
" .  Scan current buffer
" w  Scan other windows
" b  Scan buffers in the buffer list
" u  Scan unloaded buffers in the buffer list
" i  Scan included files
" t  Scan tag files
set complete=.,w,b,u,t,i
" completeopt defines how to show insertion mode completions
" longest  Match longest common text
" menu     Show completion menu, unless there's only one option
set completeopt=longest,menu

" Hit tab to start autocomplete when typing, otherwise just insert a tab
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction
imap <Tab> <C-R>=Tab_Or_Complete()<CR>


" Temporary files
" Instead of having a bunch of these floating around, centralize them
" Create temp files directory if needed
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
	call mkdir($HOME.'/.vim/files')

	call mkdir($HOME.'/.vim/files/backup')
	call mkdir($HOME.'/.vim/files/swap')
	call mkdir($HOME.'/.vim/files/undo')
	call mkdir($HOME.'/.vim/files/info')
endif

" Creates a backup of a file when you open it
set backup                               " Use backup files 
set backupext =-vimbackup                " Extension for backup files
set backupskip=/tmp/*,/private/tmp/*     " Directories to not use backup files
set backupdir =$HOME/.vim/files/backup/  " Directory for backup files

" Swap files, stores changes made to buffers. Can be used to recover on crash
set updatecount=100                      " Number of chars until swap is written
set directory  =$HOME/.vim/files/swap//  " Double slash means use full path

" Stores undo history 
set undofile                        " Use undo files
set undodir=$HOME/.vim/files/undo/  " Directory for undo files

" Stores things like search history and registers on quit
" %     Store buffer list
" <1000 Store up to 800 lines in each register
" '100  Store up to 100 file marks
" /1000 Store up to 1000 searches
" :1000 Store up to 1000 commands
" Last argument is where viminfo is stored
set viminfo=%,<1000,'100,/1000,:1000,n$HOME/.vim/files/info/viminfo

" Jump to the line a file was at when it was closed
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Set vimwiki home path and tell it to use markdown
let g:vimwiki_list = [{'path': '~/Code/notes',
			\ 'syntax': 'markdown',
			\ 'ext': '.md'}]

let g:tagbar_compact=1    " Make tagbar take up less space

let NERDTreeShowHidden=1  " Show hidden files
let NERDTreeMinimalUI=1   " Make NERDTree take up less space
let NERDTreeIgnore = ['.DS_Store', 'tags', 'tags.lock']

let g:go_fmt_command="goimports"  " Run Go imports on save

let mapleader=" "         " Use <Space> as the leader key

" Global mode
map <C-n> ;NERDTreeToggle<CR>

" Normal mode remappings
nnoremap ; :
nnoremap : ;
nnoremap <leader>w <C-w>
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>j :w<Enter>
nnoremap <Leader>k :wq<Enter>
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Insert mode remappings
inoremap jk <Esc>`^

" vim-go remappings
nnoremap <Leader>s :GoBuild<Enter>

" FZF remappings
nnoremap <Leader>ff :FZF<Enter>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>ft :Tags<CR>

" Tagbar remappings
nnoremap <leader>t :TagbarToggle<CR>

" Remapping things to noop so they get out of the way
nnoremap <_> <Plug>Vimwiki2HTML
nnoremap <_> <Plug>Vimwiki2HTMLBrowse
let g:tagbar_map_showproto = '<F18>'

" Expand "dtdy" int today's date
iab dtdy <c-r>=strftime("%Y-%m-%d")<CR>

" Resize windows when vim is resized
autocmd VimResized * :wincmd =

" Don't lose selection on visual mode indent
vnoremap < <gv
vnoremap > >gv

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'
