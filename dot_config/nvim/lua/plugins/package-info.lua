return {
  "vuki656/package-info.nvim",
  branch = "master",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
  event = { "BufEnter package.json" },
  opts = {
    hide_up_to_date = true,
  },
  config = function(_, opts)
    require("package-info").setup(opts)
    vim.keymap.set(
      { "n" },
      "<leader>nt",
      require("package-info").toggle,
      { silent = true, noremap = true, desc = "Toggle versions" }
    )
    vim.keymap.set(
      { "n" },
      "<leader>nu",
      require("package-info").update,
      { silent = true, noremap = true, desc = "Update dependency" }
    )
    vim.keymap.set(
      { "n" },
      "<leader>nd",
      require("package-info").delete,
      { silent = true, noremap = true, desc = "Delete dependency" }
    )
    vim.keymap.set(
      { "n" },
      "<leader>ni",
      require("package-info").install,
      { silent = true, noremap = true, desc = "Install dependency" }
    )
    vim.keymap.set(
      { "n" },
      "<leader>nv",
      require("package-info").change_version,
      { silent = true, noremap = true, desc = "Change version" }
    )
  end,
}
