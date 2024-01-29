vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            require("conform").format({ async = true, lsp_fallback = true })
        end, { desc = "Format current buffer" })

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
        -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
    end,
})

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "b0o/schemastore.nvim",

        -- Rust
        { "rust-lang/rust.vim" },
        {
            'mrcjkb/rustaceanvim',
            version = '^4',
            ft = { 'rust' },
        },
        {
            'saecki/crates.nvim',
            tag = 'stable',
            config = function()
                require('crates').setup()
            end,
        }
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "html",
                "jsonls",
                'eslint',
                "vimls",
                "yamlls",
                'gopls',
                'tailwindcss',
                "dockerls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            },
        })
        require("neodev").setup()
        local lspconfig = require('lspconfig')

        local generalLsCapabilities = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            return capabilities
        end

        lspconfig.tsserver.setup({
            on_attach = function(client)
                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.document_range_formatting = false
            end
        })

        lspconfig.html.setup({
            capabilities = generalLsCapabilities(),
        })

        lspconfig.sqlls.setup({
            cmd = { "sql-language-server", "up", "--method", "stdio" },
            root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
            filetypes = { "sql" },
        })

        lspconfig.lua_ls.setup({
            -- before_init = require("neodev.lsp").before_init,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    },
                }
            },
        })

        lspconfig.yamlls.setup({
            settings = {
                yaml = {
                    schemaStore = {
                        -- You must disable built-in schemaStore support if you want to use
                        -- this plugin and its advanced options like `ignore`.
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                    schemas = require('schemastore').yaml.schemas(),
                }
            }
        })

        lspconfig.tailwindcss.setup({
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

        lspconfig.jsonls.setup({
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            capabilities = generalLsCapabilities(),
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        vim.g.rustaceanvim = {
            -- LSP configuration
            server = {
                on_attach = function(client, bufnr)
                    vim.g.rustfmt_autosave = 1
                end,
                settings = {
                    -- rust-analyzer language server configuration
                    ['rust-analyzer'] = {
                    },
                },
            },
        }
    end,
}
