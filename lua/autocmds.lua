local augroup = vim.api.nvim_create_augroup
local general_group = augroup("GeneralGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", { clear = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = general_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
