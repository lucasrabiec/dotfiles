M = {}

function M.list_registered_providers_names(filetype)
  local available_sources = require("null-ls.sources").get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.list_supported(filetype, methods)
  local registered_providers = M.list_registered_providers_names(filetype)
  local diagnostics_providers = vim.tbl_flatten(vim.tbl_map(function(method)
    return registered_providers[method] or {}
  end, methods))

  return diagnostics_providers
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local icons = require("lazyvim.config").icons
    local function fg(name)
      return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    local function getLsp(color)
      return {
        function()
          local bufnr = vim.api.nvim_get_current_buf()

          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          if next(clients) == nil then
            return "No Active Lsp"
          end

          local c = {}
          for _, client in pairs(clients) do
            if client.name ~= "copilot" then
              table.insert(c, client.name)
            end
          end

          return "" .. table.concat(c, " | ")
        end,
        icon = " ",
        color = color,
      }
    end

    local function getFormatters(color)
      return {
        function()
          -- Check if 'conform' is available
          local status, conform = pcall(require, "conform")
          if not status then
            return "Conform not installed"
          end

          local lsp_format = require("conform.lsp_format")

          -- Get formatters for the current buffer
          local formatters = conform.list_formatters_for_buffer()
          if formatters and #formatters > 0 then
            local formatterNames = {}

            for _, formatter in ipairs(formatters) do
              table.insert(formatterNames, formatter)
            end

            return "" .. table.concat(formatterNames, " | ")
          end

          -- Check if there's an LSP formatter
          local bufnr = vim.api.nvim_get_current_buf()
          local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

          if not vim.tbl_isempty(lsp_clients) then
            return "LSP Formatter"
          end

          return ""
        end,
        icon = "󰷈",
        color = color,
      }
    end

    local function getLinters(color)
      return {
        function()
          local linters = require("lint").get_running()
          if #linters == 0 then
            return "󰦕"
          end
          return "󱉶 " .. table.concat(linters, " | ")
        end,
        color = color,
      }
    end

    local diagnostics = {
      "diagnostics",
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
    }
    local filetype = { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }
    local filename = { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } }
    local navic = {
      function()
        return require("nvim-navic").get_location()
      end,
      cond = function()
        return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
      end,
    }
    local cwd_dir = {
      function()
        return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
      -- color = fg("Special"),
    }

    opts.theme = "nightfly"
    opts.options.disabled_filetypes.winbar = { "dashboard", "lazy", "alpha", "DiffviewFiles" }
    opts.winbar = {
      lualine_c = { filetype, filename },
      lualine_y = {
        { "copilot", show_colors = true, show_loading = true },
        getLsp(fg("Special")),
        getFormatters(fg("Special")),
        getLinters(fg("Special")),
      },
    }
    opts.inactive_winbar = { lualine_c = { filetype, filename }, lualine_x = { getLsp() } }

    opts.sections.lualine_a = { {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } }
    opts.sections.lualine_b = { "branch" }
    opts.sections.lualine_c = { diagnostics, navic }
    opts.sections.lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = fg("Statement")
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = fg("Constant") ,
        },
      { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
      },
    }
    opts.sections.lualine_y = {
      cwd_dir,
    }
    opts.sections.lualine_z = {
      { "progress", separator = " ", padding = { left = 1, right = 0 }, icon = { "󱎂" } },
      { "location", padding = { left = 0, right = 1 } },
    }
  end,
}
