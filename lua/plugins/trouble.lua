return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("trouble").setup()
        vim.api.nvim_set_keymap(
            "n",
            "<leader>ge",
            "<cmd>Trouble document_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>gE",
            "<cmd>Trouble workspace_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
    end,
}
