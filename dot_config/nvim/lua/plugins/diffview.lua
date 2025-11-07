return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  dependencies = "nvim-lua/plenary.nvim",
  opts = function()
    local actions = require("diffview.actions")
    return {
      keymaps = {
        view = {
          -- instead of cycle through another buffer, move around window
          { "n", "<tab>", actions.focus_files, { desc = "Move to next window" } },
          { "n", "q", "<cmd>tabclose<cr>", { desc = "Close" } },
        },
        file_panel = {
          -- just select them when moving
          { "n", "j", actions.select_next_entry, { desc = "Select next entry" } },
          { "n", "k", actions.select_prev_entry, { desc = "Select previous entry" } },
          { "n", "<down>", actions.select_next_entry, { desc = "Select next entry" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Select previous entry" } },
          -- all of them to just go to the diff2 (right panel) so you can edit right at the Diffview tab
          { "n", "gf", actions.focus_entry, { desc = "Focus entry" } },
          { "n", "<tab>", actions.focus_entry, { desc = "Focus entry" } },
          { "n", "<cr>", actions.focus_entry, { desc = "Focus entry" } },
          -- these are extra that also makes sense to me
          { "n", "h", actions.toggle_flatten_dirs, { desc = "Toggle flatten dirs" } },
          { "n", "l", actions.focus_entry, { desc = "Focus entry" } },
          { "n", "q", "<cmd>tabclose<cr>", { desc = "Close" } },
        },
      },
    }
  end,
}
