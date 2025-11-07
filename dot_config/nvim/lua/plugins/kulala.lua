return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  opts = {
    split_direction = "horizontal",
    default_view = "headers_body",
    contenttypes = {
      ["application/problem+json"] = {
        formatter = { "jq", "." },
        ft = "json",
      },
    },
  },
  keys = function()
    return {
      { "<leader>R", "", desc = "+Rest", ft = "http" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", ft = "http" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", ft = "http" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
    }
  end,
}
