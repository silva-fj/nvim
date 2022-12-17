vim.api.nvim_set_keymap("n", "<Leader>gs", ":Git<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>gd", ":Gdiffsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>gb", ":GBrowse<CR>", { noremap = true })

vim.cmd([[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]])
