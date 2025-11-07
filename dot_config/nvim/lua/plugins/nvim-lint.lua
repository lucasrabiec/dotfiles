return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost" },
    linters_by_ft = {
      markdown = { "" },
    },
  },
}
