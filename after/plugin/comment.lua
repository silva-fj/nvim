require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	toggler = {
		---Line-comment toggle keymap
		line = "<leader>cc",
		---Block-comment toggle keymap
		block = "<leader>cb",
	},
	opleader = {
		---Line-comment keymap
		line = "<leader>cc",
		---Block-comment keymap
		block = "<leader>cb",
	},
	mappings = {
		extra = false,
	},
})
