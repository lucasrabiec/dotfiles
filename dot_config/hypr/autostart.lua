-- Extra autostart processes.
-- o.launch_on_start("my-service")
-- Session restore: reopen last session's windows, then re-save every 60s.
local hsr = "~/.local/bin/hypr-session-restore"
o.exec_on_start("sleep 2 && " .. hsr .. " restore")
o.launch_on_start("sh -c '" .. hsr .. " daemon'")
