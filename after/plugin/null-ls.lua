local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.xo,
    },
})
