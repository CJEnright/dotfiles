local map = vim.keymap.set

map("n", ";", ":")
map("n", "<Leader>j", "<cmd>w<CR>")
map("n", "<Leader>k", "<cmd>wq<CR>")
map("n", "<Leader>/", "<cmd>nohlsearch<CR>")
map("n", "<Leader>w", "<C-w>")
map("n", "<Leader><Leader>", "<C-^>")

-- Notes
map("n", "<Leader>nn", "<cmd>e ~/Code/notes/index.md<CR>")
map("n", "<Leader>nj", "<cmd>e ~/Code/notes/journal.md<CR>")
map("n", "<Leader>nl", "<cmd>e ~/Code/notes/log.md<CR>")

map("i", "jk", "<ESC>")
