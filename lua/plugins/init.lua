return {
    "RRethy/vim-illuminate",
    "tpope/vim-rhubarb",
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },

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
        config = function()
            require("lualine").setup()
        end,
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
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = false,
                filetypes = {
                    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx',
                    'jsx', 'rescript',
                    'xml',
                    'php',
                    'markdown',
                    'astro', 'glimmer', 'handlebars', 'hbs'
                }
            })
        end,
    },
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
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
            vim.api.nvim_set_keymap(
                "v",
                "<leader>rr",
                ":lua require('refactoring').select_refactor()<CR>",
                { noremap = true, silent = true, expr = false }
            )
        end,
    },
    {
        "github/copilot.vim",
        config = function()
            vim.cmd([[
               imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
               imap <silent> <C-h> <Plug>(copilot-next)
               imap <silent> <C-y> <Plug>(copilot-previous)
               let g:copilot_no_tab_map = v:true
            ]])
        end,
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
