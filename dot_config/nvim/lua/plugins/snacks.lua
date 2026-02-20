---@class snacks.Config
---@field bigfile? snacks.bigfile.Config | { enabled: boolean }
---@field gitbrowse? snacks.gitbrowse.Config
---@field lazygit? snacks.lazygit.Config
---@field notifier? snacks.notifier.Config | { enabled: boolean }
---@field quickfile? { enabled: boolean }
---@field statuscolumn? snacks.statuscolumn.Config  | { enabled: boolean }
---@field styles? table<string, snacks.win.Config>
---@field dashboard? snacks.dashboard.Config  | { enabled: boolean }
---@field terminal? snacks.terminal.Config
---@field toggle? snacks.toggle.Config
---@field win? snacks.win.Config
---@field words? snacks.words.Config

return {

  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- disable scrolling animations
    },
    explorer = {
      enabled = false,
    },
    dashboard = {
      formats = {
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "normal" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      preset = {
        header = [[
██╗     ██╗   ██╗ ██████╗ █████╗ ███████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║     ██║   ██║██╔════╝██╔══██╗██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
██║     ██║   ██║██║     ███████║███████╗   ██╔██╗ ██║██║   ██║██║██╔████╔██║
██║     ██║   ██║██║     ██╔══██║╚════██║   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗╚██████╔╝╚██████╗██║  ██║███████║██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                                             
    ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 3, indent = 2 },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 2,
        },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 3 },
        { section = "startup" },
      },
    },
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>E", false },
      { "<leader>e", false },
    },
  },
}
