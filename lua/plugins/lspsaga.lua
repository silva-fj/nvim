return {
	"glepnir/lspsaga.nvim",
	branch = "main",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		--Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		require("lspsaga").setup({
			rename = {
				quit = "<Esc>",
				exec = "<CR>",
				mark = "x",
				confirm = "<CR>",
				in_select = true,
			},
			ui = {
				-- This option only works in Neovim 0.9
				title = true,
				-- Border type can be single, double, rounded, solid, shadow.
				border = "rounded",
				winblend = 0,
				expand = "",
				collapse = "",
				code_action = "💡",
				incoming = " ",
				outgoing = " ",
				hover = " ",
				kind = {},
			},
			symbol_in_winbar = {
				enable = false,
			},
		})

		local keymap = vim.keymap.set

		-- Code action
		keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

		-- Rename all occurrences of the hovered word for the entire file
		keymap("n", "rn", "<cmd>Lspsaga rename<CR>")

		-- Show line diagnostics
		-- You can pass argument ++unfocus to
		-- unfocus the show_line_diagnostics floating window
		keymap("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>")

		-- Show buffer diagnostics
		keymap("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<CR>")

		-- Diagnostic jump
		-- You can use <C-o> to jump back to your previous location
		keymap("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		keymap("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>")

		-- Hover Doc
		-- If there is no hover doc,
		-- there will be a notification stating that
		-- there is no information available.
		-- To disable it just use ":Lspsaga hover_doc ++quiet"
		-- Pressing the key twice will enter the hover window
		keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

		-- Floating terminal
		keymap({ "n", "t" }, "<leader>t", "<cmd>Lspsaga term_toggle<CR>")
	end,
}
