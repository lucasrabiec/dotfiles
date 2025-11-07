return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
    "nvim-mini/mini.pick", -- optional
  },
  config = true,
  opts = {
    mappings = {
      finder = {
        ["<c-f>"] = "Next",
        ["<c-b>"] = "Previous",
      },
    },
  },
}
