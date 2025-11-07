local detail = false
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  keys = {
    {
      "<leader>e",
      "<cmd>Oil --float<cr>",
      desc = "Open file explorer",
    },
  },
  opts = {
    skip_confirm_for_simple_edits = true,
    columns = {
      "icon",
    },
    delete_to_trash = true,
    git = {
      -- Return true to automatically git add/mv/rm files
      add = function(path)
        return true
      end,
      mv = function(src_path, dest_path)
        return true
      end,
      rm = function(path)
        return true
      end,
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 170,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },
    keymaps = {
      [";"] = { "actions.parent", mode = "n" },
      ["<C-s>"] = {
        desc = "Save changes",
        callback = function()
          require("oil").save()
        end,
      },
      ["q"] = {
        desc = "Save changes and close",
        callback = function()
          require("oil").save({}, function()
            vim.cmd.quit()
          end)
        end,
      },
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["<C-h"] = false,
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    },
    view_options = {
      is_hidden_file = function(name, bufnr)
        return name ~= ".." and not string.match(name, ".env") and vim.startswith(name, ".")
      end,
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
}
