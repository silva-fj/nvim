local prettier = { "prettierd", "prettier" }
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
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
            rust = { "rustfmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        log_level = vim.log.levels.DEBUG,
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
        conform.formatters.rustfmt = {
            inherit = false,
            command = "shfmt",
            args = { "--edition 2021", "--emit=stdout" },
        }
    end,
}
