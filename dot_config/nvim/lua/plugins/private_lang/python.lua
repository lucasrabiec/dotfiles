return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                -- typeCheckingMode = "off",
                autoImportCompletions = true,
              },
            },
          },
        },
      },
    },
  },
}
