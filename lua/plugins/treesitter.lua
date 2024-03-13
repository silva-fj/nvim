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
                    'astro', 'glimmer', 'handlebars', 'hbs',
                    'rust'
                }
            })
        end,
    }
}
