return {
  "nvim-mini/mini.indentscope",
  version = false,
  enabled = false,
  opts = {
    draw = {
      delay = 0,
      animation = function()
        return function()
          return 0
        end
      end,
    },
  },
}
