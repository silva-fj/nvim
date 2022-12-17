local map = vim.api.nvim_set_keymap

map("", "<space>", "<leader>", {})
map("", "<leader>qq", ":qall<cr>", {})
map("n", "<leader>w", ":bd<cr>", {})

local options = { noremap = true }
map("n", "<leader>s", ":w<cr>", options)
map("n", "<leader><space>", ":nohlsearch<cr>", options)
map("n", "<C-k>", ":TmuxNavigateUp<cr>", options)
-- map("n", "U", "*", options) -- let's try with normal key
map("n", "Y", "y$", options)
map("n", "<A-j>", ":m .+1<cr>==", options)
map("n", "<A-k>", ":m .-2<cr>==", options)
map("n", "<A-j", "<Esc>:m .+1<cr>==gi", options)
map("n", "<A-k", "<Esc>:m .-2<cr>==gi", options)
map("n", "<A-j", ":m '>+1<cr>gv=gv", options)
map("n", "<A-k", ":m '<-2<cr>gv=gv", options)
map("n", "<C-u>", "<C-u>zz", options)
map("n", "<C-d>", "<C-d>zz", options)
map("n", "n", "nzz", options)

-- Keep it centered
map("n", "n", "nzzzv", options)
map("n", "N", "Nzzzv", options)
map("n", "J", " mzJ`z", options)
