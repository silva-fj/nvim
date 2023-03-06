return {
	-- Colorschemes
	-- gruvbox
	{ "ellisonleao/gruvbox.nvim" },
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
	-- nord
	{
		"shaunsingh/nord.nvim",
	},
	-- codedark
	{
		"tomasiser/vim-code-dark",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("codedark")
		end,
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
	"ray-x/lsp_signature.nvim",

	-- Git
	"tpope/vim-rhubarb",
	{
		"kdheepak/lazygit.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "<Leader>lg", ":LazyGit<CR>", { noremap = true, silent = true })
		end,
	},

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
		version = "v3.*",
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
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
		end,
	},
	"folke/lsp-colors.nvim",
	{
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()
			local keymap = vim.keymap.set

			-- Code action
			keymap({ "n" }, "<leader>S", "<cmd>lua require('spectre').open()<CR>")
		end,
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
}
