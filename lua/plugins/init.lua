return {
    "RRethy/vim-illuminate",
    "tpope/vim-rhubarb",
    "christoomey/vim-tmux-navigator",
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        config = true,
    },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    "tpope/vim-surround",
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                -- user_default_options = {
                -- 	tailwind = true,
                -- },
            })
        end,
    },
    {
        "windwp/nvim-spectre",
        config = function()
            require("spectre").setup()

            -- Code action
            vim.keymap.set({ "n" }, "<leader>S", "<cmd>lua require('spectre').open()<CR>")
            vim.keymap.set("n", "<leader>SS", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
                desc = "Search on current file",
            })
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
        },
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
            vim.keymap.set("n", "<leader>m", require("treesj").toggle)
        end,
    },
    -- {
    --     "airblade/vim-gitgutter",
    -- },
    {
        'mg979/vim-visual-multi',
        branch = 'master',
    },
}
