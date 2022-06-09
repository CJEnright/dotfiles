local nore = { noremap=true, silent=true }

local keymap = vim.api.nvim_set_keymap

keymap("n", ";", ":", nore)
keymap("n", "<Leader>j", ":w<CR>", nore)
keymap("n", "<Leader>k", ":wq<CR>", nore)
keymap("n", "<Leader>/", ":nohlsearch<CR>", nore)
keymap("n", "<Leader>w", "<C-w>", nore)
-- Switch to previous buffer
keymap("n", "<Leader><Leader>", "<C-^>", nore)

-- Telescope
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", nore)
keymap("n", "<Leader>fg", ":Telescope live-grep<CR>", nore)
keymap("n", "<Leader>fb", ":Telescope buffers<CR>", nore)

-- Notes
keymap("n", "<Leader>nn", ":e ~/Code/notes/index.md<CR>", nore)
keymap("n", "<Leader>nj", ":e ~/Code/notes/journal.md<CR>", nore)
keymap("n", "<Leader>nl", ":e ~/Code/notes/log.md<CR>", nore)

keymap("i", "jk", "<ESC>", nore)
