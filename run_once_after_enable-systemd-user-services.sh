#!/bin/sh

# Enable the systemd user services managed by chezmoi (runs once per machine).
# timewarrior-sync.service has no [Install] section; .zshrc starts it after the
# SSH key is loaded.

# rclone mount points
mkdir -p "${HOME}/Sync/gdrive-priv" "${HOME}/Sync/gdrive-1mb"

systemctl --user daemon-reload

# SSH agent is needed right away (git externals, ssh-add in .zshrc)
systemctl --user enable --now ssh-agent.service

# rclone mounts start on next login: rclone is installed by abrakadabra.sh and
# each remote needs `rclone config reconnect <remote>:` first
systemctl --user enable rclone-gdrive-priv.service rclone-gdrive-1mb.service
