# dotfiles (🐧 Omarchy)

![Wallpaper](https://raw.githubusercontent.com/lucasrabiec/dotfiles/refs/heads/main/dot_config/omarchy/backgrounds/dracula/sunset-lake.png)

## 📀 OS Download

- [Omarchy](https://omarchy.org/)

For MacOS configuration click [here](https://rickrolled.com/?title=Download+MacOS&desc=How+to+download+and+install+macOS).

## ⚔️ Brace yourself

<img width="400" src="https://static.prsa.pl/images/a27d63a8-3495-4f29-ac70-62f97e40def8.file" />
<br/>
**"Przed wyruszeniem w drogę należy zebrać drużynę"**
<br/>
<strong>("You must gather your party before venturing forth")<sup>1</sup></strong>

1. Configure Limine
   1. Disable Secure Boot in BIOS and install Omarchy
   1. Change Boot priority to Limine
   1. Run `limine-scan` in terminal and choose Windows Boot Manager - it should add record to `/boot/limine.conf`
   1. Run `sudo nvim /boot/limine.conf` and change timeout to `10` and set default entry (from 1)
1. Fix a clock issue with Dual Boot - run this command in linux terminal: `timedatectl set-local-rtc 1`
1. Install:
   - [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default)
   - [1Password CLI](https://developer.1password.com/docs/cli/) and Application - secrets for chezmoi templates. Check `Integrate with 1Password CLI` in `Settings > Developer` before `chezmoi init`.
1. Set up the SSH key - it is needed before `chezmoi init`, because the `nvim` and `timewarrior-data` externals are cloned over SSH
   1. Put the private key in `~/.ssh/id_ed25519` (`chmod 600`) and make sure its public key is added to GitHub
   1. Load keys automatically - open `nvim ~/.ssh/config` and save this:

      ```
      Host *
        AddKeysToAgent yes
      ```

   1. Load it for the current session: `eval "$(ssh-agent)" && ssh-add ~/.ssh/id_ed25519`

1. Add locale
   1. Open `sudo nvim /etc/locale.gen` and uncomment `pl.PL.utf8` then save
   1. Call `sudo locale-gen`
1. Clear preconfigured omarchy's nvim to apply clean config from chezmoi
   1. Remove `omarchy-nvim` package
   1. Remove nvim from `~/.local/share/` and `~/.config/`
1. Install chezmoi and init with this repo: `chezmoi init --apply git@github.com:lucasrabiec/dotfiles.git`
1. Run the `abrakadabra.sh` script to remove unnecessary apps/packages and install the required ones (antidote, oh-my-posh, yazi, rclone, ...). `.zshrc` needs some of them, so do it right after `chezmoi init`:

   ```sh
   bash ~/.local/share/chezmoi/setup/abrakadabra.sh
   ```

1. Log in to Google Drive for each rclone remote (tokens are not stored in the repo), then log out and back in to start the mounts:

   ```sh
   rclone config reconnect gdrive-priv:
   rclone config reconnect gdrive-1mb:
   ```

1. Configure zsh
   - [oh-my-posh](https://ohmyposh.dev) - the most customizable and fastest prompt engine for any shell. Installed by `abrakadabra.sh`, configured in `.zshrc` with `~/.dracula.omp.json`.
1. Install all needed languages and packages for nvim. Open nvim and run `:checkhealth` command then install missing stuff.
   - Install languages and tools through Omarchy's `Install > Development` menu except python
   - For python versioning and venvs use `uv` (installed via `mise` or Arch repo)
   - NodeJS should be managed by `mise`

## 🗂️ What chezmoi manages

Besides the regular dotfiles:

- **Externals** (`.chezmoiexternal.toml`) - cloned/downloaded on `chezmoi apply`, refreshed weekly (`chezmoi apply --refresh-externals` to force):
  - `~/.config/nvim` - [nvim config](https://github.com/lucasrabiec/nvim) (daily)
  - `~/.local/share/timewarrior/data` - timewarrior data repo (synced by `timewarrior-sync.service`)
  - `~/.config/omarchy/themes/dracula` - [Dracula theme](https://github.com/catlee/omarchy-dracula-theme)
  - `~/.config/omarchy/plugins/*` - [now-playing](https://github.com/bjarneo/omarchy-now-playing), [linear](https://github.com/gpdenny/omarchy-linear)
  - `~/.config/tmux/plugins/tpm` - [tmux plugin manager](https://github.com/tmux-plugins/tpm)
  - `~/.local/bin/hypr-session-restore` - [Hyprland session restore](https://github.com/UpayanChatterjee/hypr-session-restore), started in `hypr/autostart.lua`
- **Scripts**
  - `run_onchange_after_install-tmux-plugins.sh` - installs TPM plugins whenever `tmux.conf` changes
  - `run_once_after_enable-systemd-user-services.sh` - enables `ssh-agent` and the rclone mounts once per machine
- **Secrets** - `~/.config/rclone/rclone.conf` is created from a template with the Google client from 1Password. It is written only if missing, so rclone can keep refreshing its own token.
- **Hooks** - `~/.config/omarchy/hooks/post-update.d/yazi-plugins.hook` runs `ya pkg upgrade` after every Omarchy update.

## 🧛🏻‍♂️ Theming

<img width="400" src="https://github.com/user-attachments/assets/b6920e5d-0804-40ae-84ce-eed89cddfdc5" />
<br/>

**One [theme](https://draculatheme.com). All platforms.**

- [OS](https://draculatheme.com/omarchy) (Omarchy only)
  - [catlee/omarchy-dracula-theme](https://github.com/catlee/omarchy-dracula-theme) - installed by chezmoi as an external, then `omarchy-theme-set dracula`
- [Ghostty](https://draculatheme.com/ghostty)
- Wallpapers - [sunset-lake](dot_config/omarchy/backgrounds/dracula/sunset-lake.png) and [reverie](dot_config/omarchy/backgrounds/dracula/reverie.jpg) in `~/.config/omarchy/backgrounds/dracula/`, added to the theme's own backgrounds

---

<sup>1</sup> Polish acting legend Piotr Fronczewski - the Polish narrator's voice in Baldur’s Gate II.
