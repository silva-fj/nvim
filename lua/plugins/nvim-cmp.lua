return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },
        { "petertriho/cmp-git" },
        {
            "roobert/tailwindcss-colorizer-cmp.nvim",
            -- optionally, override the default options:
            config = function()
                require("tailwindcss-colorizer-cmp").setup({
                    color_square_width = 2,
                })
            end,
        },
        { "onsails/lspkind.nvim" },
        {
            "L3MON4D3/LuaSnip",
            version = "V2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            config = function()
                vim.cmd([[
                      " Expand
                      imap <expr> <A-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'
                      smap <expr> <A-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'

                      " Jump
                      imap <expr> <A-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
                      smap <expr> <A-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
                   ]])
            end,
        },
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" }
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }

        require('luasnip.loaders.from_vscode').lazy_load()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- that way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping({
                    i = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({
                        select = false,
                    }),
                }),
                ['<C-k>'] = function()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
                { name = "git" },
            },
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    show_labelDetails = true,
                    before = function(entry, vim_item)
                        return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                    end
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            experimental = {
                ghost_text = false, -- this feature conflict with copilot.vim's preview.
            },
            view = {
                docs = {
                    auto_open = false
                }
            },

        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
        })
    end,
}
