return {
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        lazy = false,
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            vim.g.skip_ts_context_commentstring_module = true
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
                toggler = {
                    ---Line-comment toggle keymap
                    line = "<leader>cc",
                    ---Block-comment toggle keymap
                    block = "<leader>bb",
                },
                opleader = {
                    ---Line-comment keymap
                    line = "<leader>cc",
                    ---Block-comment keymap
                    block = "<leader>bb",
                },
                mappings = {
                    extra = false,
                },
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    }
}
