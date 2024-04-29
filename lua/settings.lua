local set = vim.o

set.autowrite = true
set.scrolloff = 10
set.si = true
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.smartindent = true
set.number = true
set.relativenumber = false
set.splitbelow = true
set.splitright = true
set.shell = "/bin/zsh"
set.termguicolors = true
set.backup = false
set.writebackup = false
set.signcolumn = "yes"
set.cmdheight = 1
set.mouse = "a"
set.showmode = false
set.undofile = true

vim.opt.breakindent = true
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.wildignore = { "*/temp/*", "*.so", "*.zip", "*/node_modules/*", "*/vendor/bundle/*", "*/vendor/*" }
vim.opt.hlsearch = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Show which line your cursor is on
vim.opt.cursorline = true

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.o`
