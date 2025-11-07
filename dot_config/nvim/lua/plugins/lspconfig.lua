local format = require("lazyvim.util.format").format
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {
        on_attach = function(_, bufnr)
          -- vim.api.nvim_create_autocmd({ "BufWritePre", "BufLeave", "WinLeave", "FocusLost" }, {
          vim.api.nvim_create_autocmd({ "BufWritePre", "WinLeave", "FocusLost" }, {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_dir = require("lspconfig.util").find_git_ancestor,
      },
      vtsls = {
        settings = {
          vtsls = {
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
              maxInlayHintLength = 50,
            },
          },
        },
        keys = {
          {
            "gD",
            function()
              local params = vim.lsp.util.make_position_params()
              LazyVim.lsp.execute({
                command = "typescript.goToSourceDefinition",
                arguments = { params.textDocument.uri, params.position },
                open = true,
              })
            end,
            desc = "Goto Source Definition",
          },
          {
            "gR",
            function()
              LazyVim.lsp.execute({
                command = "typescript.findAllFileReferences",
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              })
            end,
            desc = "File References",
          },
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
          {
            "<leader>ci",
            LazyVim.lsp.action["source.addMissingImports.ts"],
            desc = "Add missing imports",
          },
          {
            "<leader>cu",
            LazyVim.lsp.action["source.removeUnused.ts"],
            desc = "Remove unused imports",
          },
          {
            "<leader>cD",
            LazyVim.lsp.action["source.fixAll.ts"],
            desc = "Fix all diagnostics",
          },
          {
            "<leader>cV",
            function()
              LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
            end,
            desc = "Select TS workspace version",
          },
          { "<leader>cf", false },
          { "<leader>cF", format, desc = "Format Document", has = "documentFormatting" },
          { "<leader>cF", format, desc = "Format Range", mode = "v", has = "documentFormatting" },
        },
      },
    },
  },
}
