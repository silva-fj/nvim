return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-cmdline" },
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
            config = function()
                vim.cmd([[
                      " Expand
                      imap <expr> <C-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'
                      smap <expr> <C-j>   luasnip#expandable()  ? '<Plug>luasnip-expand-snippet' : '<C-j>'

                      " Jump
                      imap <expr> <C-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
                      smap <expr> <C-l>   luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-l>'
                   ]])
            end,
        },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            "tsserver",
            "eslint",
            "lua_ls",
            "rust_analyzer",
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }
        local cmp_mappings = lsp.defaults.cmp_mappings({
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping({
                i = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({
                    select = false,
                }),
            }),
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        lsp.setup_nvim_cmp({
            -- preselect = cmp.PreselectMode.None,
            mapping = cmp_mappings,
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
                    vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[Buffer]",
                            vsnip = "[VSNIP]",
                            nvim_lua = "[Lua]",
                            path = "[PATH]",
                        })[entry.source.name]

                    return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                end,
            },
            experimental = {
                ghost_text = false, -- this feature conflict with copilot.vim's preview.
            },
        })

        -- Fix Undefined global 'vim'
        lsp.configure("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        lsp.configure("tsserver", {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })

        local jsonlsCapabilities = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            return capabilities
        end

        lsp.configure("tailwindcss", {
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

        lsp.configure("jsonls", {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            capabilities = jsonlsCapabilities(),
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

        lsp.on_attach(function(client, bufnr)
            print("LSP started.")
            require("illuminate").on_attach(client)
            require("lsp_signature").on_attach({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded",
                },
            }, bufnr)

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                if vim.lsp.buf.format then
                    vim.lsp.buf.format()
                elseif vim.lsp.buf.formatting then
                    vim.lsp.buf.formatting()
                end
            end, { desc = "Format current buffer with LSP" })

            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

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
            -- nmap("<space>ld", vim.diagnostic.open_float, "[L]ine [D]iagnostic")
            nmap("ff", "<cmd>Format<CR>", "[F]ormat [F]ile")

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
        end)

        lsp.nvim_workspace()

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = false,
            float = true,
        })
    end,
}
