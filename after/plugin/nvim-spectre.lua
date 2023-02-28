local keymap = vim.keymap.set

-- Code action
keymap({ "n" }, "<leader>S", "<cmd>lua require('spectre').open()<CR>")
