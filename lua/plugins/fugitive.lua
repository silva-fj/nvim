return {
    "tpope/vim-fugitive",
    config = function()
        vim.api.nvim_set_keymap("n", "<Leader>gs", ":Git<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>gd", ":Gvdiffsplit<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>gD", ":Gvdiffsplit!<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>gb", ":GBrowse<CR>", { noremap = true })
    end,
}
