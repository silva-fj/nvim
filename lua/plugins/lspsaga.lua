vim.diagnostic.config({
    severity_sort = true,
})
return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lspsaga").setup({
            rename = {
                in_select = false,
                auto_save = false,
                project_max_width = 0.5,
                project_max_height = 0.5,
                keys = {
                    quit = "<Esc>",
                    exec = "<CR>",
                    select = "x",
                },
            },
            ui = {
                border = "single",
                devicon = true,
                title = true,
                expand = "⊞",
                collapse = "⊟",
                code_action = "💡",
                actionfix = " ",
                lines = { "┗", "┣", "┃", "━", "┏" },
                kind = nil,
                imp_sign = "󰳛 ",
            },
            symbol_in_winbar = {
                enable = false,
            },
            lightbulb = {
                enable = true,
                sign = true,
                virtual_text = false
            },
            code_action = {
                num_shortcut = true,
                show_server_name = true,
                extend_gitsigns = true,
            },
        })

        local keymap = vim.keymap.set

        -- Code action
        -- keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

        -- Rename all occurrences of the hovered word for the entire file
        -- keymap("n", "rn", "<cmd>Lspsaga rename<CR>")

        -- Show line diagnostics
        -- You can pass argument ++unfocus to
        -- unfocus the show_line_diagnostics floating window
        keymap("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>")

        -- You can use <C-o> to jump back to your previous location
        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

        -- Hover Doc
        -- If there is no hover doc,
        -- there will be a notification stating that
        -- there is no information available.
        -- To disable it just use ":Lspsaga hover_doc ++quiet"
        -- Pressing the key twice will enter the hover window
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

        -- Floating terminal
        keymap({ "n", "t" }, "<leader>t", "<cmd>Lspsaga term_toggle<CR>")
    end,
}
