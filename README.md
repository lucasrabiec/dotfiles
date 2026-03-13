# dotfiles (🐧 Omarchy)

![Wallpaper](https://raw.githubusercontent.com/lucasrabiec/dotfiles/refs/heads/main/dot_config/omarchy/themes/dracula/backgrounds/sunset-lake.png)

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
   - zsh theme - [dracula](https://draculatheme.com/zsh) is the best
   - [age](https://github.com/FiloSottile/age) - for chezmoi encryption.
1. Save ssh keys for current session

   Open `nvim ~/.ssh/config` and save this:

   ```
   Host *
     AddKeysToAgent yes
   ```

1. Add locale and apply waybar config
   1. Open `sudo nvim /etc/locale.gen` and uncomment `pl.PL.utf8` then save
   1. Call `sudo locale-gen`
   1. Apply Waybar config with `omarchy-restart-waybar`
1. Clear preconfigured omarchy's nvim to apply clean config from chezmoi
   1. Remove `omarchy-nvim` package
   1. Remove nvim from `~/.local/share/` and `~/.config/`
1. Install chezmoi and init with this repo url.
1. Configure zsh
   - Install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - a delightful community-driven framework for managing zsh configuration.
   - Install [oh-my-posh](https://ohmyposh.dev) - the most customizable and fastest prompt engine for any shell.
     - `eval "$(oh-my-posh init zsh --config ~/.dracula.omp.json)"`
   - Install [zsh-autosuggestions]() and [zsh-syntax-highlights]
1. Install all needed languages and packages for nvim. Open nvim and run `:checkhealth` command then install missing stuff.
   - Install languages and tools through Omarchy's `Install > Development` menu except python
   - For python versioning and venvs use `uv` (installed via `mise` or Arch repo)
   - NodeJS should be managed by `mise`
1. Run the `abrakadabra.sh` script to remove unnecessary apps/packages and install the required ones

## 🧛🏻‍♂️ Theming

<img width="400" src="https://github.com/user-attachments/assets/b6920e5d-0804-40ae-84ce-eed89cddfdc5" />
<br/>

**One [theme](https://draculatheme.com). All platforms.**

- [OS](https://draculatheme.com/omarchy) (Omarchy only)
  - `omarchy-theme-install https://github.com/catlee/omarchy-dracula-theme`
- [Ghostty](https://draculatheme.com/ghostty)
- [Wallpaper](https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/themes/tokyo-night/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png)
  - `cd /home/lucas/.config/omarchy/backgrounds/dracula`
  - `curl https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/themes/tokyo-night/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png --output=sunset-lake.png`

---

<sup>1</sup> Polish acting legend Piotr Fronczewski - the Polish narrator's voice in Baldur’s Gate II.
