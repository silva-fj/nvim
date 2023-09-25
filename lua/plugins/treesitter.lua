return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "rust", "typescript", "tsx", "css", "graphql", "html", "javascript", "lua", "scss", "vim", "go", "yaml",
                "toml", "terraform", "svelte", "sql", "json", "gitignore", "diff", "git_rebase", "gitcommit",
                "dockerfile", "dart", "cmake", "bash"
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
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}
