vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

local set_mappings = function(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format current buffer" })

    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("ff", "<cmd>Format<CR>", "[F]ormat [F]ile")

    -- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    -- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", function()
        require("telescope.builtin").lsp_references({ layout_strategy = "vertical" })
    end, "[G]oto [R]eferences")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", function()
        require("telescope.builtin").lsp_document_symbols({ layout_strategy = "vertical" })
    end, "[D]ocument [S]ymbols")
    nmap("<leader>ws", function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({ layout_strategy = "vertical" })
    end, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
end

local generalLsCapabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end


return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
        },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },
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

        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            version = "V2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()

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

        -- RUST
        { "rust-lang/rust.vim" },
        { "simrat39/rust-tools.nvim" },
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            lsp_zero.default_keymaps({ buffer = bufnr })
            require("illuminate").on_attach(client)
            set_mappings(bufnr)
        end)

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'tsserver',
                'eslint',
                'lua_ls',
                'gopls',
                'yamlls',
                'html',
                'sqlls',
                'tailwindcss',
                'jsonls'
            },
            handlers = {
                lsp_zero.default_setup,
                tsserver = function()
                    require('lspconfig').tsserver.setup({
                        on_attach = function(client, bufnr)
                            client.resolved_capabilities.document_formatting = false
                            client.resolved_capabilities.document_range_formatting = false
                        end
                    })
                end,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                }
                            }
                        }
                    })
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                yamlls = function()
                    require('lspconfig').yamlls.setup({
                        {
                            keyOrdering = false,
                            settings = {
                                yaml = {
                                    schemas = {
                                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                                            "docker-compose*.yml",
                                            "docker-compose.*.yml",
                                            "compose.*.yml",
                                            "compose-*.yml",
                                        },
                                    },
                                },
                            },
                        }
                    })
                end,
                html = function()
                    require('lspconfig').html.setup({
                        capabilities = generalLsCapabilities(),
                    })
                end,
                sqlls = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.sqlls.setup({
                        cmd = { "sql-language-server", "up", "--method", "stdio" },
                        root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
                        filetypes = { "sql" },
                    })
                end,
                tailwindcss = function()
                    require('lspconfig').tailwindcss.setup({
                        settings = {
                            tailwindCSS = {
                                experimental = {
                                    classRegex = {
                                        { "cva|cx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                                    },
                                },
                            },
                        },
                    })
                end,
                jsonls = function()
                    require('lspconfig').jsonls.setup({
                        on_attach = function(client)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                        capabilities = generalLsCapabilities(),
                        settings = {
                            json = {
                                -- Schemas https://www.schemastore.org
                                schemas = {
                                    { fileMatch = { "package.json" },   url = "https://json.schemastore.org/package.json" },
                                    { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
                                    {
                                        fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                                        url = "https://json.schemastore.org/prettierrc.json",
                                    },
                                    {
                                        fileMatch = { ".eslintrc", ".eslintrc.json" },
                                        url = "https://json.schemastore.org/eslintrc.json",
                                    },
                                    {
                                        fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                                        url = "https://json.schemastore.org/babelrc.json",
                                    },
                                    {
                                        fileMatch = { "lerna.json" },
                                        url = "https://json.schemastore.org/lerna.json",
                                    },
                                    { fileMatch = { "now.json", "vercel.json" }, url = "https://json.schemastore.org/now.json" },
                                    {
                                        fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
                                        url = "http://json.schemastore.org/stylelintrc.json",
                                    },
                                },
                            },
                        },
                    })
                end
            },
        })

        local cmp = require('cmp')
        -- local cmp_format = require('lsp-zero').cmp_format()
        local cmp_action = require('lsp-zero').cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }

        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        vsnip = "[VSNIP]",
                        luasnip = "[LuaSNIP]",
                        nvim_lua = "[Lua]",
                        path = "[PATH]",
                    })[entry.source.name]

                    return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                ["<CR>"] = cmp.mapping({
                    i = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({
                        select = false,
                    }),
                }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
            },
            experimental = {
                ghost_text = false, -- this feature conflict with copilot.vim's preview.
            },

        })

        local rust_tools = require("rust-tools")

        rust_tools.setup({
            server = {
                on_attach = function(_, bufnr)
                    -- Auto format on save
                    vim.g.rustfmt_autosave = 1
                    set_mappings(bufnr)
                end,
                cargo = {
                    features = { "all" },
                },
                procMacro = {
                    ignored = {
                        leptos_macro = {
                            -- optional: --
                            "component",
                            "server",
                        },
                    },
                },
            },
        })
    end,
}
