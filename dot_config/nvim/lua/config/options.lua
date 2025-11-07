-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.swapfile = false
opt.scrolloff = 8
opt.list = false
opt.completeopt = "menu,menuone,noinsert,noselect"
opt.clipboard = "unnamedplus"
opt.showtabline = 0
opt.termguicolors = true
opt.conceallevel = 1
vim.g.snacks_animate = false
