-- Misc
-- %= align right, %l line number, %c column number
vim.opt.rulerformat = "%=%l:%c" 
-- Show cursor stats in bottom left
vim.opt.ruler = true
-- Prompt when trying to quit without saving
vim.opt.confirm = true
-- Open new splits to the right of the current one
vim.opt.splitright = true
-- Open new splits below the current one
vim.opt.splitbelow = true
-- Always show at least 5 lines on top or bottom 
vim.opt.scrolloff = 5
-- Always show at least 5 characters to the left or right
vim.opt.sidescrolloff = 5
-- Interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250
vim.opt.fillchars = {
  -- Don't put characters in split dividers
  vert = " ",
  -- Disable tilde on end of buffer
  eob = " "
}
-- Imagine using a mouse
vim.opt.mouse = ""

-- Search
-- Search highlighting
vim.opt.hlsearch = true
-- Start searching as you type
vim.opt.incsearch = true
-- Ignore case
vim.opt.ignorecase = true
-- Only use case when search has capitals
vim.opt.smartcase = true

-- Indentation
-- Type spaces when you hit tab
--vim.opt.expandtab = true
-- Copy indention depth on new line
vim.opt.autoindent = true
-- Tabs take up 2 columns
vim.opt.tabstop = 2
-- Indent 2 columns with '<<' and '>>'
vim.opt.shiftwidth = 2
-- Use multiples of shiftwidth when indenting with '<<' and '>>'
vim.opt.shiftround = true

-- Colors
-- Highlight line cursor is on
vim.opt.cursorline = true
-- Custom color scheme, defined in colors/bw.vim
vim.cmd [[ colorscheme bw ]]

-- Spell checking
-- Enable spell checking
vim.opt.spell = true 
-- Use English spell checking
vim.opt.spelllang = "en_us"

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }

-- Temporary files
-- Instead of having a bunch of these floating around, centralize them
-- Create temp files directory if needed
local tmp_path = vim.fn.stdpath "data" .. "/tmp"
if not vim.fn.isdirectory(vim.fn.glob(tmp_path)) then
  vim.fn.mkdir(tmp_path)

  vim.fn.mkdir(tmp_path .. "/backup")
  vim.fn.mkdir(tmp_path .. "/swap")
  vim.fn.mkdir(tmp_path .. "/undo")
end

-- Use backup files 
-- Creates a backup of a file when you open it
vim.opt.backup = true
-- File extension for backups
vim.opt.backupext = "-vimbackup"
-- Directories to not use backup files
vim.opt.backupskip =  "/tmp/*,/private/tmp/*"
-- Directory for backup files
vim.opt.backupdir = tmp_path .. "/backup"

-- Swap files, stores changes made to buffers
-- Can be used to recover on crash
-- Double slash means use full path
vim.opt.directory = tmp_path .. "/swap//"

-- Stores undo history 
-- Use undo files
vim.opt.undofile = true
-- Directory for undo files
vim.opt.undodir = tmp_path .. "/undo/"


-- Always open files to the line it was at when it was closed
vim.cmd [[
  augroup remember_cursor_position  
      autocmd!  
      autocmd BufReadPost \* if line("'\\"") > 1 && line("'\\"") <= line("$") | exe "normal! g`\"" | call timer\_start(1, {tid -> execute("normal! zz")})  | endif  
  augroup END
]]

-- Plugin options

require'nvim-tree'.setup {
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        git = false
      },
      glyphs = {
        folder = {
          arrow_closed = "▸",
          arrow_open = "▾"
        }
      }
    }
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  },
  view = {
    side = "right"
  }
}


