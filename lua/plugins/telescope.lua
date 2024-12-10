return {
    "nvim-telescope/telescope.nvim",
    event = 'VimEnter',
    version = "0.1.X",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
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
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        })
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")

        local no_preview = function()
            return require("telescope.themes").get_dropdown({
                borderchars = {
                    { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                    preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
                width = 0.8,
                previewer = false,
                prompt_prefix = "🔍 ",
            })
        end

        local project_files = function(preview)
            local opts = {
                -- layout_strategy = "vertical",
                prompt_prefix = "🔍 ",
            }
            vim.fn.system("git rev-parse --is-inside-work-tree")
            if vim.v.shell_error == 0 then
                if preview == true then
                    require("telescope.builtin").git_files(opts)
                else
                    require("telescope.builtin").git_files(no_preview())
                end
            else
                if preview == true then
                    require("telescope.builtin").find_files(opts)
                else
                    require("telescope.builtin").find_files(no_preview())
                end
            end
        end

        vim.keymap.set("n", "<leader>sf", function()
            project_files(false)
        end, { desc = "[S]earch [P]project [F]iles (No Preview)" })

        vim.keymap.set("n", "<leader>?", function()
            builtin.oldfiles({ layout_strategy = "vertical" })
        end, { desc = "[?] Find recently opened files" })

        vim.keymap.set("n", "<leader>sg", function()
            builtin.live_grep({ layout_strategy = "vertical" })
        end, { desc = "[S]earch by [G]rep" })

        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord in Buffer' })

        -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

        vim.keymap.set("n", "<Leader>spw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word, layout_strategy = "vertical" })
        end)

        vim.keymap.set("n", "<leader><space>", function()
            builtin.buffers({ layout_strategy = "vertical" })
        end, { desc = "[ ] Find existing buffers" })

        vim.keymap.set("n", "<leader>fh", function()
            builtin.help_tags({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [H]elp" })

        vim.keymap.set("n", "<C-p>", function()
            project_files(true)
        end, { desc = "[S]earch [P]project files (Preview)" })

        vim.keymap.set("n", "<Leader>f", function()
            builtin.grep_string({ search = vim.fn.input("Search 🔍 "), layout_strategy = "vertical" })
        end)

        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer]" })

        vim.keymap.set("n", "<leader>sd", function()
            require("telescope.builtin").diagnostics({ layout_strategy = "vertical" })
        end, { desc = "[S]earch [D]iagnostics" })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
    end,
}
