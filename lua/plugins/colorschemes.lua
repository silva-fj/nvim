return {
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "dracula/vim",
        name = "dracula",
    },
    {
        "olimorris/onedarkpro.nvim",
        name = "onedarkpro",
    },
    { "Mofiqul/vscode.nvim" },
    {
        "mhartington/oceanic-next",
        name = "oceanic-next"
    },
    { "folke/tokyonight.nvim" },
    {
        "tomasiser/vim-code-dark",
        name = "codedark",
    },
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end,

    },
}
