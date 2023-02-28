return {
    -- Colorschemes
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    "mhartington/oceanic-next",
    "Mofiqul/vscode.nvim",
    "ellisonleao/gruvbox.nvim",
    "mhartington/oceanic-next",
    "folke/tokyonight.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },
    "RRethy/vim-illuminate",
    -- Fuzzy finder
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-cmdline" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    {
        -- Useful status updates for LSP
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup()
        end,
    },
    "ray-x/lsp_signature.nvim",

    -- Git
    "tpope/vim-rhubarb",
    "lewis6991/gitsigns.nvim",
    "kdheepak/lazygit.nvim",

    -- Comments
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
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
    { "nvim-tree/nvim-tree.lua",                  dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "romgrk/barbar.nvim",                       dependencies = "nvim-tree/nvim-web-devicons" },
    "lukas-reineke/indent-blankline.nvim",
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    "tpope/vim-surround",
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "kosayoda/nvim-lightbulb",
        config = function()
            require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
        end,
    },
    "folke/lsp-colors.nvim",
    {
        "windwp/nvim-spectre",
        config = function()
            require("spectre").setup()
        end,
    },
}
