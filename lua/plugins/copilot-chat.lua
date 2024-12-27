# remove this after upgrading neovim to 0.11.0+
vim.o.completeopt = "menu,preview,noinsert,popup"

return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" }
        },
        build = "make tiktoken",
        opts = {
            highlight_headers = false,
            separator = '---',
            error_header = '> [!ERROR] Error',
            model = "o1",
            debug = false, -- Enable debugging
            chat_autocomplete = true,
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
                "<cmd>CopilotChatCommit<cr>",
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
