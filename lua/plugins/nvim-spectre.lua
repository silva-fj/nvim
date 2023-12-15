return {
    "windwp/nvim-spectre",
    config = function()
        require("spectre").setup()

        vim.keymap.set({ "n" }, "<leader>S", "<cmd>lua require('spectre').open()<CR>")
        vim.keymap.set("n", "<leader>SS", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
            desc = "Search on current file",
        })
    end,
}
