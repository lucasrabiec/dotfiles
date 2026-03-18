---@module 'snacks'

local Actions = require("snacks.explorer.actions")
local Tree = require("snacks.explorer.tree")

-- Weak keys prevent keeping dead picker objects alive
local input_leave_hooks = setmetatable({}, { __mode = "k" })
local last_list_file = setmetatable({}, { __mode = "k" })

local function is_dirname(picker, item)
  return item.file == vim.fs.dirname(picker:cwd())
end

local function is_cwd(picker, item)
  return item.file == picker:cwd()
end

-- Move cursor back to the file list if the search input is empty
local function focus_list_if_input_empty(picker)
  if not picker:is_focused() then
    return
  end

  local input_win = picker.input and picker.input.win
  local list_win = picker.list and picker.list.win

  if not input_win or not list_win or not vim.api.nvim_win_is_valid(list_win.win) then
    return
  end

  local line = vim.api.nvim_buf_get_lines(input_win.buf, 0, 1, false)[1] or ""
  if line ~= "" then
    return
  end

  vim.api.nvim_set_current_win(list_win.win)

  local file = last_list_file[picker]
  if file then
    Actions.update(picker, { target = file })
  else
    picker.list:set_target(1)
  end
end

---@class snacks.Picker
---@field cwd_jumplist {[string]:snacks.picker.Item}

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
  lazy = false,
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer (current file)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer (current file)", remap = true },
  },
  ---@type snacks.Config
  opts = {
    scroll = {
      enabled = false, -- disable scrolling animations
    },
    explorer = {
      enabled = true,
    },
    picker = {
      sources = {
        explorer = {
          tree = false,
          follow_file = true,
          auto_close = true,
          jump = { close = true },
          layout = {
            preset = "default",
            ---@diagnostic disable-next-line: assign-type-mismatch
            preview = true,
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 80,
              max_width = 140,
              height = 0.5,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = true, width = 0.6 },
            },
          },
          finder = function(opts, ctx)
            local fun = require("snacks.picker.source.explorer").explorer(opts, ctx)
            local dirname = vim.fs.dirname(ctx:cwd())
            return function(cb)
              cb({ parent_dir = true, file = dirname, text = "../ " .. dirname, dir = true, open = true })
              fun(cb)
            end
          end,
          icons = {
            tree = { last = "", middle = "", vertical = "" },
          },
          on_show = function(picker)
            picker.cwd_jumplist = {}

            local input_win = picker.input and picker.input.win
            -- Attach InsertLeave handler only once per picker instance
            if input_win and not input_leave_hooks[picker] then
              input_leave_hooks[picker] = true

              -- When leaving insert mode in input, move to list if input is empty
              input_win:on({ "InsertLeave" }, function()
                focus_list_if_input_empty(picker)
              end)
            end
          end,
          transform = function(item, ctx)
            local no_tree = ctx.picker.opts.tree == false ---@diagnostic disable-line
            if no_tree and ctx.filter.meta.searching ~= true then
              -- NOTE: Filter cwd item: `./`
              if is_cwd(ctx.picker, item) then
                return false
              end
              -- Hide nested
              item.open = false
              return vim.tbl_get(item, "parent", "parent") == nil
            end
          end,
          -- Display `../`, `./`
          format = function(item, picker)
            local fmt = Snacks.picker.format.file(item, picker)
            local ico = item.open and picker.opts.icons.files.dir_open or picker.opts.icons.files.dir
            if picker.input.filter.meta.searching == true then
              return fmt
            elseif is_dirname(picker, item) then
              fmt[1] = { ico, "MiniIconsAzure" }
              fmt[2] = { "../", "SnacksPickerDirectory" }
            elseif is_cwd(picker, item) then
              fmt[1] = { ico, "MiniIconsAzure" }
              fmt[2] = { "./", "SnacksPickerDirectory" }
            end
            return fmt
          end,
          -- Override `confirm`
          config = function(opts)
            opts = require("snacks.picker.source.explorer").setup(opts) ---@diagnostic disable-line
            opts.actions.confirm = function(picker, item, action)
              if picker.input.filter.meta.searching then
                if not item.dir then
                  Snacks.picker.actions.jump(picker, item, action)
                  return
                end
                picker:set_cwd(item.file)
                Actions.update(picker, { refresh = true, target = item.file })
              elseif is_dirname(picker, item) then
                picker:action("explorer_up")
              elseif is_cwd(picker, item) then -- noop
              elseif item.dir then
                picker:set_cwd(item.file)
                local target = picker.cwd_jumplist[item.file]
                Actions.update(picker, { refresh = true, target = target })
              else
                Actions.actions.confirm(picker, item, action)
              end
            end

            return opts
          end,
          actions = {
            -- NOTE: Override `explorer_up`
            explorer_up = function(picker, item)
              local cwd = picker:cwd()
              ---@diagnostic disable-next-line: assign-type-mismatch
              picker.cwd_jumplist[cwd] = item.file
              picker:set_cwd(vim.fs.dirname(cwd))
              Actions.update(picker, { refresh = true, target = cwd })
            end,
            go_left = function(picker)
              picker:action("explorer_up")
            end,
            go_right = function(picker, item)
              if not is_dirname(picker, item) and not is_cwd(picker, item) then
                picker:action("confirm")
              end
            end,
            go_to_input = function(picker)
              -- Remember selected file before entering input
              local item = picker:current()
              if item and item.file then
                last_list_file[picker] = item.file
              end

              vim.api.nvim_set_current_win(picker.input.win.win)
              vim.cmd("startinsert")
            end,
            explorer_add_cwd = function(picker)
              Snacks.input({
                prompt = 'Add a new file or directory (directories end with a "/")',
              }, function(value)
                if not value or value:find("^%s*$") then
                  return
                end

                -- Always create relative to current explorer cwd
                local base = picker:cwd()
                local path = svim.fs.normalize(base .. "/" .. value)

                local is_file = value:sub(-1) ~= "/"
                local dir = is_file and vim.fs.dirname(path) or path

                if is_file and vim.uv.fs_stat(path) then
                  Snacks.notify.warn("File already exists:\n- `" .. path .. "`")
                  return
                end

                vim.fn.mkdir(dir, "p")

                if is_file then
                  local f = io.open(path, "w")
                  if f then
                    f:close()
                  end
                end

                Tree:open(dir)
                Tree:refresh(dir)
                Actions.update(picker, { target = path })
              end)
            end,
          },
          win = {
            list = {
              keys = {
                ["h"] = "go_left",
                ["l"] = "go_right",
                ["i"] = "go_to_input",
                ["a"] = "explorer_add_cwd",
                ["A"] = "explorer_add",
              },
            },
          },
        },
      },
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
    image = {
      resolve = function(path, src)
        local api = require("obsidian.api")
        if api.path_is_note(path) then
          return api.resolve_image_path(src)
        else
          return path
        end
      end,
    },
  },
}
