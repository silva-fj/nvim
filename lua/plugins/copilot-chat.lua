return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "github/copilot.vim" },    -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" }
        },
        opts = {
            model = "gpt-4o-2024-08-06",
            debug = false, -- Enable debugging
            -- default mappings
            mappings = {
                complete = {
                    detail = 'Use @<Tab> or /<Tab> for options.',
                    insert = '<Tab>',
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>'
                },
                reset = {
                    normal = '<C-l>',
                    insert = '<C-r>'
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-CR>'
                },
                accept_diff = {
                    normal = '<C-y>',
                    insert = '<C-y>'
                },
                show_diff = {
                    normal = 'gd'
                },
                show_system_prompt = {
                    normal = 'gp'
                },
                show_user_selection = {
                    normal = 'gs'
                },
            },
        },
        keys = {
            {
                "<leader>cp",
                "<cmd>CopilotChatToggle<cr>",
                desc = "CopilotChat - Toggle Vsplit",
            },
            -- Quick chat
            {
                "<leader>cpq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },
            -- Generate commit message for staged changes
            {
                "<leader>cpc",
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Show prompts actions with telescope
            {
                "<leader>cpp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            -- Explain code
            {
                "<leader>cpe",
                "<cmd>CopilotChatExplain<cr>",
                desc = "CopilotChat - Explain code",
            },
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
