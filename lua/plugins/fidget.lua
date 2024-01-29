-- Useful status updates for LSP
return {
    "j-hui/fidget.nvim",
    opts = {
        integration = {
            ["nvim-tree"] = {
                enable = true,
            },
        },
        -- Options related to logging
        logger = {
            level = vim.log.levels.WARN, -- Minimum logging level
            float_precision = 0.01,      -- Limit the number of decimals displayed for floats
            path =                       -- Where Fidget writes its logs to
                string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
    },
}
