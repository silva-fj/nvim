return {
	-- Colorschemes
	-- gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	-- Dracula
	{
		"dracula/vim",
		name = "dracula",
	},
	-- onedark
	{ "olimorris/onedarkpro.nvim" },
	-- vscode
	{
		"Mofiqul/vscode.nvim",
	},
	-- OceanicNext
	{
		"mhartington/oceanic-next",
	},
	-- tokyonight
	{
		"folke/tokyonight.nvim",
	},
	-- codedark
	{
		"tomasiser/vim-code-dark",
	},
	-- nightfly
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
	},

	"RRethy/vim-illuminate",
	{
		-- Useful status updates for LSP
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
		tag = "legacy",
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ge",
				"<cmd>Trouble document_diagnostics<cr>",
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>gE",
				"<cmd>Trouble workspace_diagnostics<cr>",
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
		end,
	},

	-- Git
	"tpope/vim-rhubarb",
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},

	"christoomey/vim-tmux-navigator",
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		config = function()
			require("lualine").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	"tpope/vim-surround",
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				enable_close_on_slash = false,
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				-- user_default_options = {
				-- 	tailwind = true,
				-- },
			})
		end,
	},
	{
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()

			-- Code action
			vim.keymap.set({ "n" }, "<leader>S", "<cmd>lua require('spectre').open()<CR>")
			vim.keymap.set("n", "<leader>SS", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
			vim.api.nvim_set_keymap(
				"v",
				"<leader>rr",
				":lua require('refactoring').select_refactor()<CR>",
				{ noremap = true, silent = true, expr = false }
			)
		end,
	},
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[
               imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
               imap <silent> <C-h> <Plug>(copilot-next)
               imap <silent> <C-y> <Plug>(copilot-previous)
               let g:copilot_no_tab_map = v:true
            ]])
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
			vim.keymap.set("n", "<leader>m", require("treesj").toggle)
		end,
	},
}
