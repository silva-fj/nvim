return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Adapters
        'nvim-neotest/neotest-jest',
        'rouge8/neotest-rust',
        -- "marilari88/neotest-vitest",
        -- "thenbe/neotest-playwright",
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-jest"),
                -- require("neotest-vitest"),
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
        vim.keymap.set("n", "<leader>tt", function()
            neotest.run.run()
        end, {})
        vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, {})
        vim.keymap.set("n", "<leader>ts", function()
            neotest.summary.toggle()
        end, {})
    end
}
