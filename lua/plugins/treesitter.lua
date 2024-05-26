return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "rust", "typescript", "tsx", "css", "graphql", "html", "javascript", "lua", "scss", "vim", "go",
                    "yaml",
                    "toml", "terraform", "svelte", "sql", "json", "gitignore", "diff", "git_rebase", "gitcommit",
                    "dockerfile", "dart", "cmake", "bash", "http", "markdown", "markdown_inline",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                -- indent = {
                --     enable = true,
                -- },
                ignore_install = { "vala", "swift" },
            })
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
