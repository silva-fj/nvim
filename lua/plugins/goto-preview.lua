return {
    "rmagatti/goto-preview",
    config = function()
        require("goto-preview").setup()
        vim.api.nvim_set_keymap(
            "n",
            "gp",
            "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
            { noremap = true }
        )
    end,
}
