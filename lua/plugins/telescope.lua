return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = { ["<esc>"] = require("telescope.actions").close },
                },
                layout_config = {
                    vertical = { width = 0.8 },
                },
            },
        })
        require("telescope").load_extension("fzf")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>sf", function()
            builtin.find_files({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [F]iles" })

        vim.keymap.set("n", "<leader>?", function()
            builtin.oldfiles({ layout_strategy = "vertical" })
        end, { desc = "[?] Find recently opened files" })

        vim.keymap.set("n", "<leader>sg", function()
            builtin.live_grep({ layout_strategy = "vertical" })
        end, { desc = "[S]earch by [G]rep" })

        vim.keymap.set("n", "<leader>b", function()
            builtin.buffers({ layout_strategy = "vertical" })
        end, { desc = "[ ] Find existing buffers" })

        vim.keymap.set("n", "<leader>fh", function()
            builtin.help_tags({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [H]elp" })

        vim.keymap.set("n", "<C-p>", function()
            builtin.git_files({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [G]it files" })

        vim.keymap.set("n", "<Leader>f", function()
            builtin.grep_string({ search = vim.fn.input("Search 🔍 "), layout_strategy = "vertical" })
        end)

        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer]" })

        vim.keymap.set("n", "<leader>sd", function()
            require("telescope.builtin").diagnostics({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [D]iagnostics" })
    end,
}
