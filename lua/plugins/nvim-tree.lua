return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			local git_add = function()
				local node = api.tree.get_node_under_cursor()
				local gs = node.git_status.file

				-- If the current node is a directory get children status
				if gs == nil then
					gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
						or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
				end

				-- If the file is untracked, unstaged or partially staged, we stage it
				if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
					vim.cmd("silent !git add " .. node.absolute_path)

					-- If the file is staged, we unstage
				elseif gs == "M " or gs == "A " then
					vim.cmd("silent !git restore --staged " .. node.absolute_path)
				end

				api.tree.reload()
			end

			local function edit_or_open()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil then
					-- expand or collapse folder
					api.node.open.edit()
				else
					-- open file
					api.node.open.edit()
					-- Close the tree if file was opened
					api.tree.close()
				end
			end

			-- open as vsplit on current node
			local function vsplit_preview()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil then
					-- expand or collapse folder
					api.node.open.edit()
				else
					-- open file as vsplit
					api.node.open.vertical()
				end

				-- Finally refocus on tree if it was lost
				api.tree.focus()
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

			vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
			vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
			vim.keymap.set("n", "h", api.tree.close, opts("Close"))
			vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
			vim.keymap.set("n", "ga", git_add, opts("Git Add"))
			vim.keymap.set("n", "c", copy_file_to, opts("Copy File To"))
		end

		-- Automatically open file upon creation
		local api = require("nvim-tree.api")
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)

		require("nvim-tree").setup({
			on_attach = on_attach,
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
