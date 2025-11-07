-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local del = vim.api.nvim_del_keymap

del("n", "<leader><tab>l")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")
del("n", "<c-_>")

vim.api.nvim_set_keymap("n", "Q", "<Nop>", {})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- map("n", "d", '"_d', { noremap = true, silent = true })
-- map("n", "dd", '"_dd', { noremap = true, silent = true })

-- Center on scrolling
map("n", "<C-u>", "<cmd>lua vim.cmd('normal! <C-u>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-d>", "<cmd>lua vim.cmd('normal! <C-d>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-f>", "<cmd>lua vim.cmd('normal! <C-f>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-b>", "<cmd>lua vim.cmd('normal! <C-b>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")

-- Map for Tmux
-- map("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
-- map("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
-- map("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
-- map("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })

-- Other

local function mapResize(directions)
  map("n", directions.up, "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", directions.down, "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", directions.left, "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", directions.right, "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

if vim.fn.has("mac") == 1 then
  mapResize({ up = "<A-Up>", down = "<A-Down>", left = "<A-Left>", right = "<A-Right>" })
  del("n", "<C-Up>")
  del("n", "<C-Down>")
  del("n", "<C-Left>")
  del("n", "<C-Right>")
end

require("which-key").add({
  { "<leader><tab>", hidden = true },
  { "gp", group = "preview" },
  { "<leader>n", group = "npm package" },
  { "<leader>S", group = "spectre" },
})

vim.keymap.set("n", "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set("n", "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })

-- Override Lazygit keys by Neogit
local neogit = require("neogit")

vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ cwd = LazyVim.root.git() })
end, { desc = "Neogit (Root Dir)" })

vim.keymap.set("n", "<leader>gG", function()
  neogit.open()
end, { desc = "Neogit (cwd)" })

vim.keymap.set("n", "<leader>gb", Snacks.git.blame_line, { desc = "Git Blame Line" })

del("n", "<leader>gB")
map("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current File History" })

vim.keymap.set("n", "<leader>gl", neogit.action("log", "log_current"), { desc = "Neogit Log Current" })

del("n", "<leader>gL")
vim.keymap.set("n", "<leader>L", Snacks.dashboard.open, { desc = "Open Dashboard" })

vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>")
