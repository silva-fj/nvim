vim.cmd([[
    " Expand
    imap <expr> <C-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'
    smap <expr> <C-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'

    " Jump
    imap <expr> <C-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
    smap <expr> <C-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
]])
