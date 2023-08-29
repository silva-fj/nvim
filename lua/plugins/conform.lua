local prettier = { "prettierd", "prettier" }
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
        {
            "ff",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = prettier,
            typescript = prettier,
            javascriptreact = prettier,
            typescriptreact = prettier,
            css = prettier,
            html = prettier,
            json = prettier,
            jsonc = prettier,
            yaml = prettier,
            markdown = prettier,
            graphql = prettier,
            go = { "gofmt" },
            sh = { "shfmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        log_level = vim.log.levels.DEBUG,
    },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
