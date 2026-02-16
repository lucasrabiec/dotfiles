# dotfiles (🐧 Omarchy, 🍎 MacOS)

![Wallpaper](https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/themes/tokyo-night/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png)

## 📀 OS Download

- [Omarchy](https://omarchy.org/)
- [MacOS](https://rickrolled.com/?title=Download+MacOS&desc=How+to+download+and+install+macOS)

## ⚔️ Brace yourself 

1. Configure Limine
    1. Disable Secure Boot in BIOS and install Omarchy
    1. Change Boot priority to Limine
    1. Run `limine-scan` in terminal and choose Windows Boot Manager - it should add record to `/boot/limine.conf`
    1. Run `sudo nvim /boot/limine.conf` and change timeout to `10` and set default entry (from 1)
1. Fix a clock issue with Dual Boot - run this command in linux terminal: `timedatectl set-local-rtc 1`
1. Install:
    - [age](https://github.com/FiloSottile/age) - for chezmoi encryption.
    - [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default) - FTW!
    - zsh theme - [dracula](https://draculatheme.com/zsh) is the best
    - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - a delightful community-driven framework for managing zsh configuration. 
    - [oh-my-posh](https://ohmyposh.dev) - the most customizable and fastest prompt engine for any shell.
        - `eval "$(oh-my-posh init zsh --config ~/.dracula.omp.json)"`
    - nvm - node version manager
1. Save ssh keys for current session
    Open `nvim ~/.ssh/config` and save this:

    ```
    Host *
      AddKeysToAgent yes
    ```

1. Add locale and apply waybar config
    1. Open `sudo nvim /etc/locale.gen` and uncomment `pl.PL.utf8` then save
    1. Call `sudo locale-gen`
    1. Apply Waybar config with `killall waybar && waybar &`
1. Clear preconfigured omarchy's nvim to apply clean config from chezmoi
    1. Remove omarchy-nvim package
    1. Remove nvim from `~/.local/share/` and `~/.config/`
1. Install chezmoi and init with this repo url.
1. Install all needed languages and packages for nvim. Open nvim and run `:checkhealth` command then install missing stuff.

## 🛫 Insert before flight

![Piotr Fronczewski - The Polish voice behind the narrative in Baldur's Gate II](https://static.prsa.pl/images/a27d63a8-3495-4f29-ac70-62f97e40def8.file?format=400)
<br/>
**"Przed wyruszeniem w drogę należy zebrać drużynę"**
<br/>
**("You must gather your party before venturing forth")**

- [lsd](https://github.com/lsd-rs/lsd) - Next gen ls command.
- [hyprsession](https://github.com/joshurtree/hyprsession) - Session saver for Hyprland 
- [ghostty](https://ghostty.org/docs) - terminal emulator


## Web Apps (Omarchy only)
For a better experience, some programs are better installed as a web app. (SUPER, ALT + SPACE > Install > Web App)
- Microsoft Teams
- Microsoft Outlook

## 🧛🏻‍♂️ Theming
<img width="400" src="https://github.com/user-attachments/assets/b6920e5d-0804-40ae-84ce-eed89cddfdc5" />
<br/>

**One [theme](https://draculatheme.com). All platforms.**

- [OS](https://draculatheme.com/omarchy) (Omarchy only) 
    - `omarchy-theme-install https://github.com/catlee/omarchy-dracula-theme`
- [Wallpaper](https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/themes/tokyo-night/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png)
    - `cd /home/lucas/.config/omarchy/backgrounds/dracula`
    - `curl https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/themes/tokyo-night/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png --output=sunset-lake.png`
