return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install({
                "rust", "typescript", "tsx", "css", "graphql", "html", "javascript", "lua", "scss", "vim", "go",
                "yaml",
                "toml", "terraform", "svelte", "sql", "json", "gitignore", "diff", "git_rebase", "gitcommit",
                "dockerfile", "dart", "cmake", "bash", "http", "markdown", "markdown_inline",
            }):wait(300000) -- wait max. 5 minutes
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
            })
        end,
    }
}
