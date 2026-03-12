-- Misc
vim.opt.rulerformat = "%=%l:%c"
vim.opt.ruler = true
vim.opt.confirm = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.updatetime = 250
vim.opt.fillchars = {
  vert = " ",
  eob = " ",
}
vim.opt.mouse = ""

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- Colors
vim.opt.cursorline = true
vim.cmd.colorscheme("bw")

-- Spell checking (only for prose)
vim.opt.spelllang = "en_us"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function() vim.opt_local.spell = true end,
})

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }

-- Temporary files
local tmp_path = vim.fn.stdpath("data") .. "/tmp"
if vim.fn.isdirectory(tmp_path) == 0 then
  vim.fn.mkdir(tmp_path, "p")
  vim.fn.mkdir(tmp_path .. "/backup")
  vim.fn.mkdir(tmp_path .. "/swap")
  vim.fn.mkdir(tmp_path .. "/undo")
end

vim.opt.backup = true
vim.opt.backupext = "-vimbackup"
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.backupdir = tmp_path .. "/backup"
vim.opt.directory = tmp_path .. "/swap//"
vim.opt.undofile = true
vim.opt.undodir = tmp_path .. "/undo/"

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.schedule(function() vim.cmd("normal! zz") end)
    end
  end,
})

-- Abbreviations
vim.cmd.iabbrev("dtdy", "<c-r>=strftime('%Y-%m-%d')<CR>")
vim.cmd.iabbrev("tsmp", "<c-r>=strftime('%T')<CR>")
