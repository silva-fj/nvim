return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
        config = function()
            local ensure_installed = {
                "rust", "typescript", "tsx", "css", "graphql", "html", "javascript", "lua", "scss", "vim", "go",
                "yaml", "toml", "terraform", "svelte", "sql", "json", "gitignore", "diff", "git_rebase", "gitcommit",
                "dockerfile", "dart", "cmake", "bash", "http", "markdown", "markdown_inline",
            }
            local installed = require('nvim-treesitter.config').get_installed()
            local to_install = vim.iter(ensure_installed)
                :filter(function(p) return not vim.tbl_contains(installed, p) end)
                :totable()
            if #to_install > 0 then
                require('nvim-treesitter').install(to_install)
            end
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
