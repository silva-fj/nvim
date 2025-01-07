return {
    "github/copilot.vim",
    config = function()
        vim.cmd([[
               imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
               imap <silent> <C-h> <Plug>(copilot-next)
               imap <silent> <C-y> <Plug>(copilot-previous)
               let g:copilot_no_tab_map = v:true
            ]])
        -- require('avante_lib').load()
    end,
}
