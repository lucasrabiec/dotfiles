-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function lazyaugroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

autocmd({ "BufLeave", "WinLeave", "FocusLost" }, {
  callback = function()
    local curbuf = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_get_option(curbuf, "modified") or vim.fn.getbufvar(curbuf, "&modifiable") == 0 then
      return
    end

    vim.cmd([[silent! update]])
  end,
  pattern = "*",
  group = lazyaugroup("autosave"),
})

local DiffViewGroup = augroup("DiffviewGroup", { clear = true })

autocmd("User", {
  callback = function()
    require("lualine").hide({
      place = { "winbar" },
      unhide = false,
    })
  end,
  pattern = "DiffviewViewOpened",
  group = DiffViewGroup,
})

autocmd("User", {
  callback = function()
    require("lualine").hide({ unhide = true })
  end,
  pattern = "DiffviewViewClosed",
  group = DiffViewGroup,
})

autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" -- Don't continue comments with o and O
    vim.opt.formatoptions = vim.opt.formatoptions - "r" -- Don't continue comments with enter
  end,
  desc = "Don't continue comments with o, O and Enter",
})

autocmd("Filetype", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Set tab width to 4 for python files",
})
