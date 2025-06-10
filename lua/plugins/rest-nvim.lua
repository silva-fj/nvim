return {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "vhyrro/luarocks.nvim",
    },
    config = function()
        require("rest-nvim").setup()

        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>Rest run<cr>", opts)
        vim.api.nvim_set_keymap("n", "<leader>rl", "<cmd>Rest run last<cr>", opts)
    end
}
