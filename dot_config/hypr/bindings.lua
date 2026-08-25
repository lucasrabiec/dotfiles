-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Move focus with SUPER + vim navigation
o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
hl.unbind("SUPER + L") -- old toggle workspace layout (dwindle/scrolling)
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
hl.unbind("SUPER + K") -- old show keybindings
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
hl.unbind("SUPER + J") -- old toggle window split
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))

-- Swap active window with the one next to it with SUPER + SHIFT + vim nav
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Toggle split
o.bind("SUPER + R", "Toggle window split", hl.dsp.layout("togglesplit"))

-- Toggle workspace layout (dwindle/layout)
o.bind("SUPER + BACKSLASH", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Show keybindings
o.bind("SUPER + K", "Keybindings", "omarchy-menu-keybindings")

-- Toggle window floating/tiling and center it
hl.unbind("SUPER + T") -- old toggle floating/tiling only
o.bind("SUPER + T", "Toggle window floating/tiling", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.center())
end)

-- Restart Hyprland in case of error
o.bind("SUPER + CTRL + HOME", "Restart Hyperland", "hyprctl dispatch exit && Hyprland")
