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
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            { buffer = bufnr, desc = "LSP: [C]ode [A]ction" })
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

        nmap("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")
    end,
})

--- Generates the LSP client capabilities
--- @return table
local function default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    --- Setup capabilities to support utf-16, since copilot.lua only works with utf-16
    --- this is a workaround to the limitations of copilot language server
    capabilities = vim.tbl_deep_extend('force', capabilities, {
        offsetEncoding = { 'utf-16' },
        general = {
            positionEncodings = { 'utf-16' },
        },
    })

    return capabilities
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        {
            'mrcjkb/rustaceanvim',
            version = '^6',
            lazy = false,
            ft = { 'rust' },
            init = function()
                -- Configure rustaceanvim here
                vim.g.rustaceanvim = {
                    server = {
                        capabilities = default_capabilities(),
                        offset_encoding = 'utf-16',
                        default_settings = {
                            -- rust-analyzer language server configuration
                            ['rust-analyzer'] = {
                                rust = {
                                    analyzerTargetDir = "target/nvim-rust-analyzer",
                                },
                                diagnostics = {
                                    disabled = {
                                        "macro-error",
                                    },
                                },
                                -- trace = {
                                --     server = "verbose",
                                -- },
                                server = {
                                    extraEnv = {
                                        -- RA_LOG = "project_model=debug",
                                        ["CHALK_OVERFLOW_DEPTH"] = "100000000",
                                        ["CHALK_SOLVER_MAX_SIZE"] = "100000000",
                                    },
                                },
                                cargo = {
                                    -- Check feature-gated code
                                    features = "all",
                                    extraEnv = {
                                        -- Skip building WASM, there is never need for it here
                                        ["SKIP_WASM_BUILD"] = "1",
                                    },
                                    -- buildScripts = {
                                    --     overrideCommand = {
                                    --         "cargo",
                                    --         "remote",
                                    --         "--build-env",
                                    --         "SKIP_WASM_BUILD=1",
                                    --         "--",
                                    --         "check",
                                    --         "--message-format=json",
                                    --         "--all-targets",
                                    --         "--all-features",
                                    --         "--target-dir=target/rust-analyzer"
                                    --     },
                                    -- },
                                    -- check = {
                                    --     overrideCommand = {
                                    --         "cargo",
                                    --         "remote",
                                    --         "--build-env",
                                    --         "SKIP_WASM_BUILD=1",
                                    --         "--",
                                    --         "check",
                                    --         "--workspace",
                                    --         "--message-format=json",
                                    --         "--all-targets",
                                    --         "--all-features",
                                    --         "--target-dir=target/rust-analyzer"
                                    --     },
                                    -- },
                                },
                                procMacro = {
                                    -- Don't expand some problematic proc_macros
                                    ignored = {
                                        ["async-trait"] = { "async_trait" },
                                        ["napi-derive"] = { "napi" },
                                        ["async-recursion"] = { "async_recursion" },
                                        ["async-std"] = { "async_std" },
                                    },
                                },
                                -- rustfmt = {
                                -- Use nightly formatting.
                                -- See the polkadot-sdk CI job that checks formatting for the current version used in
                                -- polkadot-sdk.
                                -- extraArgs = { "+nightly-2024-04-10" },
                                -- },
                                -- checkOnSave = {
                                --     command = "clippy",
                                -- },
                            },
                        },
                    },
                }
            end,
        },
        {
            'saecki/crates.nvim',
            tag = 'stable',
            config = function()
                local crates = require("crates")
                local opts = { silent = true }

                vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
                vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
                vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
                vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
                vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)

                crates.setup({})
            end,
        }
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "jsonls",
                "eslint",
                "vimls",
                "yamlls",
                -- "gopls",
                "tailwindcss",
                "dockerls",
                "cssls",
                "cssmodules_ls",
                "rust_analyzer",
            },
            automatic_installation = true,
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                    "ts_ls",
                    "lua_ls",
                }
            },
            handlers = {
                function(server_name)
                    if server_name ~= "rust_analyzer" then
                        local capabilities = default_capabilities()
                        capabilities = vim.tbl_deep_extend('force', capabilities,
                            require('blink.cmp').get_lsp_capabilities({}, false))
                        capabilities = vim.tbl_deep_extend('force', capabilities, {
                            textDocument = {
                                foldingRange = {
                                    dynamicRegistration = false,
                                    lineFoldingOnly = true
                                }
                            }
                        })
                        vim.lsp.config(server_name, {
                            capabilities = capabilities,
                            offset_encoding = 'utf-16',
                        })
                        vim.lsp.enable(server_name)
                    end
                end,
            },
        })
        local lspconfig = require('lspconfig')

        local generalLsCapabilities = function()
            local capabilities = default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            return require('blink.cmp').get_lsp_capabilities(capabilities)
        end

        vim.lsp.config('ts_ls', {
            settings = {
                typescript = {
                    inlayHints = {
                        -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true -- false
                    }
                },
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true
                    }
                },
            },
        })
        vim.lsp.enable('ts_ls')

        vim.lsp.config('html', {
            capabilities = generalLsCapabilities(),
        })
        vim.lsp.enable('html')

        vim.lsp.config('sqlls', {
            cmd = { "sql-language-server", "up", "--method", "stdio" },
            root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
            filetypes = { "sql" },
        })
        vim.lsp.enable('sqlls')

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                }
            },
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('yamlls', {
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
        vim.lsp.enable('yamlls')

        vim.lsp.config('tailwindcss', {
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
        vim.lsp.enable('tailwindcss')

        vim.lsp.config('jsonls', {
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
        vim.lsp.enable('jsonls')
    end,
}
