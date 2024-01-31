return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Adapters
        'nvim-neotest/neotest-jest',
        'rouge8/neotest-rust',
        -- "thenbe/neotest-playwright",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-jest"),
                -- require("neotest-playwright").adapter({
                --     options = {
                --         persist_project_selection = true,
                --         enable_dynamic_test_discovery = true,
                --     }
                -- }),
                -- require("neotest-go"),
                require("neotest-rust") {
                    args = { "--no-capture" },
                },
                -- require("neotest-foundry"),
            }
        })
        vim.keymap.set("n", "<leader>rt", function()
            require("neotest").run.run()
        end, {})
        vim.keymap.set("n", "<leader>rf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, {})
    end
}
