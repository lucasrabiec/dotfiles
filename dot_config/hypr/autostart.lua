-- Extra autostart processes.
-- o.launch_on_start("my-service")
o.launch_on_start("hyprsession")
o.launch_on_start("evolution")
o.launch_on_start("teams-for-linux")

o.launch_on_start(
	"sh -c 'systemctl --user import-environment SSH_AUTH_SOCK && systemctl --user start timewarrior-sync.service'"
)
