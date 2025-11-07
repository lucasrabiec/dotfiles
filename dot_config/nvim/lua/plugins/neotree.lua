return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
    },
  },
  -- lazy = false,
  opts = {
    window = {
      position = "float",
      popup = {
        position = { col = "50%", row = "10" },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ":~")
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 70),
            height = vim.o.lines - 20,
          }
        end,
      },
      mappings = {
        ["l"] = "open",
        ["L"] = "focus_preview",
        ["h"] = "close_node",
        ["C"] = false,
      },
    },
    filesystem = {
      filtered_items = {
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
}
