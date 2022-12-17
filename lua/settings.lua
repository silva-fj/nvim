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
set.updatetime = 300

vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.wildignore = { "*/temp/*", "*.so", "*.zip", "*/node_modules/*", "*/vendor/bundle/*", "*/vendor/*" }
