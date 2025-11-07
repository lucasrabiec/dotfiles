return {
  "rmagatti/goto-preview",
  keys = {
    { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", desc = "Preview definition" },
    { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>", desc = "Preview type definition" },
    { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", desc = "Preview implementation" },
    { "gpp", "<cmd>lua require('goto-preview').close_all_win()<cr>", desc = "Close all windows" },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<cr>", desc = "Preview reference" },
  },
  config = function()
    require("goto-preview").setup()
  end,
}
