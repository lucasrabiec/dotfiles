return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
  },
  opts = {
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = false,
    },
    indent = {
      enable = true,
      disable = { "python" },
    },
  },
}
