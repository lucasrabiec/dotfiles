return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- eslint = {
      --   on_attach = function(_, bufnr)
      --     -- vim.api.nvim_create_autocmd({ "BufWritePre", "BufLeave", "WinLeave", "FocusLost" }, {
      --     vim.api.nvim_create_autocmd({ "BufWritePre", "WinLeave", "FocusLost" }, {
      --       buffer = bufnr,
      --       command = "EslintFixAll",
      --     })
      --   end,
      --   root_dir = require("lspconfig.util").find_git_ancestor,
      -- },
    },
  },
}
