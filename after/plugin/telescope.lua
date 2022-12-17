require('telescope').setup({
    defaults = {
        mappings = {
            i = { ['<esc>'] = require('telescope.actions').close }
        },
        layout_config = {
            vertical = { width = 0.8 }
        }
    }
})
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>g', function()
    builtin.live_grep({ layout_strategy = 'vertical' })
end)

vim.keymap.set('n', '<leader>b', function()
    builtin.buffers({ layout_strategy = 'vertical' })
end)

vim.keymap.set('n', '<leader>fh', function()
    builtin.help_tags({ layout_strategy = 'vertical' })
end)

vim.keymap.set('n', '<C-p>', function()
    builtin.git_files({ layout_strategy = 'vertical' })
end)

vim.keymap.set('n', "<Leader>f", function()
    builtin.grep_string({ search = vim.fn.input('Search 🔍 '), layout_strategy = 'vertical' })
end)
