---@module 'snacks'

---@class snacks.Picker
---@field cwd_jumplist {[string]:snacks.picker.Item}

local Actions = require("snacks.explorer.actions")
local Tree = require("snacks.explorer.tree")

---@param picker snacks.Picker
---@param target? snacks.picker.Item
---@param _idx? integer
local update = function(picker, target, _idx)
  picker.list:set_target((target or {}).idx or _idx or 1)
  picker:find({
    on_done = function()
      local list_item = vim.iter(picker:items()):find(function(item)
        return target and item == target
      end)
      if list_item then
        picker.list:set_target(list_item.idx)
      end
    end,
  })
end

-- Track pickers that already have the InsertLeave hook attached
-- Weak keys prevent keeping dead picker objects alive
local input_leave_hooks = setmetatable({}, { __mode = "k" })
-- Store last selected file per picker instance
-- Weak keys avoid keeping destroyed pickers in memory
local last_list_file = setmetatable({}, { __mode = "k" })

-- Move cursor back to the file list if the search input is empty
local function focus_list_if_input_empty(picker)
  if not picker or picker.closed then
    return
  end

  -- Only handle this when the explorer itself is focused
  if not picker:is_focused() then
    return
  end

  local input_win = picker.input and picker.input.win
  local list_win = picker.list and picker.list.win

  if not input_win or not list_win then
    return
  end

  if not vim.api.nvim_win_is_valid(list_win.win) then
    return
  end

  -- Do nothing if input is not empty
  local line = vim.api.nvim_buf_get_lines(input_win.buf, 0, 1, false)[1] or ""
  if line ~= "" then
    return
  end

  -- Focus list window first
  vim.api.nvim_set_current_win(list_win.win)

  -- Restore previously selected file using explorer's native update logic
  local file = last_list_file[picker]
  if file then
    Actions.update(picker, { target = file })
  else
    picker.list:set_target(1)
  end
end

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
          filter = {
            transform = function(_, filter)
              local s = not filter:is_empty()
              filter.meta.searching = s
              return true
            end,
          },
          finder = function(opts, ctx)
            local fun = require("snacks.picker.source.explorer").explorer(opts, ctx)
            -- ! Close all dirs
            Tree:close_all(ctx.picker:cwd())
            -- Define parent `..`
            local cwd = ctx:cwd()
            local dirname = vim.fs.dirname(cwd)
            return function(cb)
              cb({ parent_dir = true, file = dirname, text = "../ " .. dirname, dir = true, open = true })
              fun(function(item)
                if item.file ~= cwd and item.file ~= dirname then
                  cb(item)
                end
              end)
            end
          end,
          -- Prevent displaying `icons.tree` ├╴
          transform = function(item)
            item.parent = nil
          end,
          -- Display parent as `../` (and subdirs while searching)
          format = function(item, picker)
            local fmt = Snacks.picker.format.file(item, picker)

            if item.parent_dir then
              fmt[1][2] = "MiniIconsAzure"
              fmt[2][1] = "../"
              return fmt
            end

            local searching = vim.tbl_get(picker.input, "filter", "meta", "searching")

            if not searching or item.dir or not item.file then
              return fmt
            end

            local cwd = picker:cwd()
            local rel = item.file

            if vim.startswith(item.file, cwd .. "/") then
              rel = item.file:sub(#cwd + 2)
            else
              rel = vim.fn.fnamemodify(item.file, ":t")
            end

            if rel:find("/", 1, true) then
              fmt[2][1] = rel
            end

            return fmt
          end,
          config = function(opts)
            -- Override `confirm`
            opts.actions.confirm = function(picker, item, action)
              local searching = vim.tbl_get(picker.input, "filter", "meta", "searching")

              if searching then
                if item.dir then
                  picker:set_cwd(item.file)
                  if picker.input then
                    picker.input:set("")
                    picker.input.filter.meta.searching = false
                  end
                  update(picker)
                else
                  picker:close()
                  vim.cmd.edit(vim.fn.fnameescape(item.file))
                end
                return
              end

              if not item.dir then
                Actions.actions.confirm(picker, item, action)
              elseif item.parent_dir then
                picker:action("explorer_up")
              else
                picker:set_cwd(item.file)
                update(picker)
              end
            end

            -- Preserve any existing on_show handler
            local old_on_show = opts.on_show
            opts.on_show = function(picker)
              -- Run original on_show first
              if old_on_show then
                old_on_show(picker)
              end

              local input_win = picker.input and picker.input.win
              -- Attach InsertLeave handler only once per picker instance
              if input_win and not input_leave_hooks[picker] then
                input_leave_hooks[picker] = true

                -- When leaving insert mode in input, move to list if input is empty
                input_win:on({ "InsertLeave" }, function()
                  focus_list_if_input_empty(picker)
                end)
              end
            end
          end,
          actions = {
            -- Override `explorer_up`
            explorer_up = function(picker, item) --[[Override]]
              local cwd = picker:cwd()
              local dirname = vim.fs.dirname(cwd)
              picker:set_cwd(dirname)
              update(picker)
            end,
            -- Other actions
            go_left = function(picker)
              picker:action("explorer_up")
            end,
            go_right = function(picker, item)
              if not item.parent_dir then
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
                if not value or value:match("^%s*$") then
                  return
                end

                -- Always create relative to current explorer cwd
                local base = picker:cwd()
                local path = vim.fs.normalize(base .. "/" .. value)

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
