local opt = vim.opt

vim.g.mapleader = " "
opt.signcolumn = "yes" -- Automatically adjust sign column
opt.scrolloff = 7 -- Lines of context
opt.wrap = true -- Disable line wrap
opt.shiftwidth = 4 -- Size of indent
opt.colorcolumn = "80" -- Line length marker
vim.g.rout_follow_colorscheme = true
vim.g.latex_to_unicode_auto = 1
vim.opt.clipboard = "unnamedplus"

vim.o.list = true
opt.relativenumber = true -- Relative line numbers
opt.number = true -- Show the current line number

