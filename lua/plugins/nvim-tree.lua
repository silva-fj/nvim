return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lib = require("nvim-tree.lib")
        local view = require("nvim-tree.view")

        local function collapse_all()
            require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
        end

        local function edit_or_open()
            -- open as vsplit on current node
            local action = "edit"
            local node = lib.get_node_at_cursor()

            -- Just copy what's done normally with vsplit
            if node.link_to and not node.nodes then
                require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
                view.close() -- Close the tree if file was opened
            elseif node.nodes ~= nil then
                lib.expand_or_collapse(node)
            else
                require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
                view.close() -- Close the tree if file was opened
            end
        end

        local function vsplit_preview()
            -- open as vsplit on current node
            local action = "vsplit"
            local node = lib.get_node_at_cursor()

            -- Just copy what's done normally with vsplit
            if node.link_to and not node.nodes then
                require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
            elseif node.nodes ~= nil then
                lib.expand_or_collapse(node)
            else
                require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
            end

            -- Finally refocus on tree if it was lost
            view.focus()
        end

        local git_add = function()
            local node = lib.get_node_at_cursor()
            local gs = node.git_status.file

            -- If the file is untracked, unstaged or partially staged, we stage it
            if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
                vim.cmd("silent !git add " .. node.absolute_path)

                -- If the file is staged, we unstage
            elseif gs == "M " or gs == "A " then
                vim.cmd("silent !git restore --staged " .. node.absolute_path)
            end

            lib.refresh_tree()
        end

        local function copy_file_to(node)
            local file_src = node["absolute_path"]
            -- The args of input are {prompt}, {default}, {completion}
            -- Read in the new file path using the existing file's path as the baseline.
            local file_out = vim.fn.input("COPY TO: ", file_src, "file")
            -- Create any parent dirs as required
            local dir = vim.fn.fnamemodify(file_out, ":h")
            vim.fn.system({ "mkdir", "-p", dir })
            -- Copy the file
            vim.fn.system({ "cp", "-R", file_src, file_out })
        end

        -- Automatically open file upon creation
        local api = require("nvim-tree.api")
        api.events.subscribe(api.events.Event.FileCreated, function(file)
            vim.cmd("edit " .. file.fname)
        end)

        local mappingsList = {
            { key = "l",  action = "edit",           action_cb = edit_or_open },
            { key = "L",  action = "vsplit_preview", action_cb = vsplit_preview },
            { key = "h",  action = "close_node" },
            { key = "H",  action = "collapse_all",   action_cb = collapse_all },
            { key = "ga", action = "git_add",        action_cb = git_add },
            { key = "c",  action = "copy_file_to",   action_cb = copy_file_to },
        }

        require("nvim-tree").setup({
            live_filter = {
                prefix = "[FILTER]: ",
                always_show_folders = false, -- Turn into false from true by default
            },
            disable_netrw = false,
            hijack_netrw = true,
            open_on_tab = false,
            hijack_cursor = false,
            update_cwd = false,
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = false,
                highlight_opened_files = "none",
                root_folder_modifier = ":~",
                indent_markers = {
                    enable = false,
                    icons = {
                        corner = "└ ",
                        edge = "│ ",
                        none = "  ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = false,
                        git = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = false,
                ignore_list = {},
            },
            system_open = {
                cmd = nil,
                args = {},
            },
            view = {
                adaptive_size = true,
                mappings = {
                    custom_only = false,
                    list = mappingsList,
                },
            },
            filters = {
                dotfiles = false,
                custom = { "^.git$", "^.yarn$" },
            },
        })

        vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>R", ":NvimTreeRefresh<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>F", ":NvimTreeFindFile<CR>", { noremap = true })
    end,
}
