local set = vim.o

set.autowrite = true
set.scrolloff = 5
set.si = true
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.smartindent = true
set.number = true
set.relativenumber = true
set.splitbelow = true
set.splitright = true
set.shell = "/bin/zsh"
set.termguicolors = true
set.backup = false
set.writebackup = false
set.signcolumn = "yes"
set.cmdheight = 1
set.updatetime = 100

vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.wildignore = { "*/temp/*", "*.so", "*.zip", "*/node_modules/*", "*/vendor/bundle/*", "*/vendor/*" }

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false
-- Save undo history
vim.o.undofile = false
