return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  opts = {
    plugins = {
      -- wezterm = {
      --   enabled = true,
      --   font = "+2", -- (10% increase per step)
      -- },
      gitsigns = true,
      twilight = { enabled = false },
      tmux = { enabled = true },
    },
  },
  keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
}
