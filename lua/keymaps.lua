-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local map = vim.api.nvim_set_keymap

map("", "<space>", "<leader>", {})
map("", "<leader>qq", ":qall<cr>", {})
map("n", "<leader>w", ":bd<cr>", {})

local options = { noremap = true }
map("n", "<leader>s", ":w<cr>", options)
map("n", "<C-k>", ":TmuxNavigateUp<cr>", options)
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

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
