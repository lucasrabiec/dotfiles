return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  cmd = "Obsidian",
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "hq",
        path = "~/Library/Mobile Documents/com~apple~CloudDocs/HQ",
      },
    },
    checkbox = {
      order = { " ", "x" },
    },
  },
  keys = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>o", "", desc = "+Obsidian", icon = { icon = " ", color = "purple" } },
      { "<leader>oo", "<cmd>Obsidian<cr>", desc = "Menu" },
      { "<leader>oO", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian" },
    })
  end,
}
