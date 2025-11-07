return {
  {
    "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup("uv")
      end
    end,
    opts = function()
      local dap = require("dap")

      dap.adapters.python = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "uv",
          args = { "run", "-q", "python", "-m", "debugpy.adapter" },
        },
      }

      local function guess_module_from_file()
        local file = vim.api.nvim_buf_get_name(0)
        local cwd = vim.fn.getcwd()
        if file == "" or cwd == "" or not vim.startswith(file, cwd .. "/") then
          return vim.fn.input("Module to run (i.e. pkg.app): ")
        end
        local rel = file:sub(#cwd + 2):gsub("%.py$", ""):gsub("/", ".")
        -- if points to __main__, cut (module.__main__ -> module)
        rel = rel:gsub("%.__main__$", "")
        return vim.fn.input("Module to run: ", rel)
      end

      local function list_pyproject_script_modules()
        local py = vim.fn.findfile("pyproject.toml", ".;")
        if py == "" then
          return {}
        end
        local lines = vim.fn.readfile(py)
        local in_scripts, out = false, {}
        for _, ln in ipairs(lines) do
          if ln:match("^%s*%[project%.scripts%]%s*$") then
            in_scripts = true
          elseif in_scripts and ln:match("^%s*%[") then
            break
          elseif in_scripts then
            -- supports "…" and '…'
            local name, target = ln:match('^%s*([%w%._%-%+]+)%s*=%s*"(.-)"%s*$')
            if not name then
              name, target = ln:match("^%s*([%w%._%-%+]+)%s*=%s*'(.-)'%s*$")
            end
            if name and target then
              local mod = target:match("^(.-):") -- "pkg.mod:func" -> "pkg.mod"
              if mod and #mod > 0 then
                table.insert(out, { label = string.format("%s → %s", name, mod), module = mod })
              end
            end
          end
        end
        return out
      end

      -- select module with dap.ui.pick_one (with coroutine) ===
      local function pick_module_from_pyproject_scripts_co()
        local scripts = list_pyproject_script_modules()
        if #scripts == 0 then
          return vim.fn.input("Module (e.g. pkg.app): ")
        end
        local dap_ui = require("dap.ui")
        -- no fourth arg callback -> if we are in coroutine, pick_one returns synchronized result
        local choice = dap_ui.pick_one(scripts, "Select script from pyproject:", function(i)
          return i.label
        end)
        if choice and choice.module then
          return choice.module
        end
        return vim.fn.input("Module (e.g. pkg.app): ")
      end

      -- helper: ensure it is in coroutine, if not, create one ===
      local function run_in_co(fn)
        if coroutine.running() then
          return fn()
        end
        return coroutine.wrap(function()
          return fn()
        end)()
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "📄 Current file (uv)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "📦 Module (uv) — select from pyproject scripts",
          module = function()
            return run_in_co(pick_module_from_pyproject_scripts_co)
          end,
          cwd = "${workspaceFolder}",
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "💡 Module (uv) — give/accept suggestion",
          module = function()
            return guess_module_from_file()
          end,
          cwd = "${workspaceFolder}",
          justMyCode = false,
        },
      }
    end,
  },
}
