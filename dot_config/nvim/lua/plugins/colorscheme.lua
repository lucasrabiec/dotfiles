return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = function(_, opts)
      local colors = require("dracula").colors()
      colors.selection = "#454158" -- Dracula PRO

      -- helpers from Tokyonight
      ---@param c  string
      local function hexToRgb(c)
        c = string.lower(c)
        return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
      end

      ---@param foreground string foreground color
      ---@param background string background color
      ---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
      local function blend(foreground, background, alpha)
        alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
        local bg = hexToRgb(background)
        local fg = hexToRgb(foreground)

        local blendChannel = function(i)
          local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
          return math.floor(math.min(math.max(0, ret), 255) + 0.5)
        end

        return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
      end

      local function darken(hex, amount, bg)
        return blend(hex, bg or colors.bg, amount)
      end

      opts.overrides = {
        -- Dashboard
        DashboardShortCut = { fg = colors.green },
        DashboardHeader = { fg = colors.purple },
        DashboardIcon = { fg = colors.orange },
        DashboardFooter = { fg = colors.yellow, italic = true },
        DashboardKey = { fg = colors.cyan },
        DashboardDesc = { fg = colors.green },

        -- Diffview
        DiffAdd = { bg = darken(colors.bright_green, 0.15) },
        DiffDelete = { fg = colors.bright_red },
        DiffChange = { bg = darken(colors.comment, 0.15) },
        DiffText = { bg = darken(colors.comment, 0.50) },

        -- illuminate
        illuminatedWord = { bg = darken(colors.comment, 0.65) },
        illuminatedCurWord = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordText = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordRead = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordWrite = { bg = darken(colors.comment, 0.65) },

        -- Notify
        -- Border
        -- NotifyERRORBorder = { fg = colors.fg, bg = colors.bg },
        -- NotifyWARNBorder = { fg = colors.fg, bg = colors.bg },
        -- NotifyINFOBorder = { fg = colors.fg, bg = colors.bg },
        -- NotifyDEBUGBorder = { fg = colors.fg, bg = colors.bg },
        -- NotifyTRACEBorder = { fg = colors.fg, bg = colors.bg },

        -- Body
        NotifyERRORBody = { fg = colors.fg, bg = colors.bg },
        NotifyWARNBody = { fg = colors.fg, bg = colors.bg },
        NotifyINFOBody = { fg = colors.fg, bg = colors.bg },
        NotifyDEBUGBody = { fg = colors.fg, bg = colors.bg },
        NotifyTRACEBody = { fg = colors.fg, bg = colors.bg },

        -- package-info
        PackageInfoOutdatedVersion = { fg = colors.bright_red },
        PackageInfoUptodateVersion = { fg = colors.bright_green },
      }
    end,
  },
}
