# .dotfiles

<br />
<p align="center">
  <a href="https://github.com/umutsevdi/dotfiles">
    <img src="https://img.icons8.com/fluency/344/fedora.png" alt="Logo" height="80">
  </a>
<p align="center">
    Configuration files that I've been using on my computer.
<p align="center">
  <img src="https://img.icons8.com/plasticine/344/bash.png" height=30 alt="Bash"><img src="https://github.com/i3/i3/raw/next/docs/logo-30.png" alt="i3 WM">
</p>

## About

This repository contains all the configuration files and scripts that I've been using on my device. I use <a href="https://getfedora.org/en/server/download/">Fedora 36 Server Edition</a>. These are the base dotfiles that I start with
when I set up a new environment.

I'm using Fedora 36 on my personal computer. I use a fork of
<a href="https://github.com/i3/i3">i3 Window Manager</a> called <a href="https://github.com/Airblader/i3">i3-gaps</a>.

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
  <li><a href="applets/">Applets</a></li>
  <li><a href="bin/">Scripts</a></li>
  <li><a href="nvim/">Neovim</a></li>
  <li><a href="polybar/">Polybar Configurations</a></li>
  <li><a href="i3/config">i3 Configurations</a></li>
  <li><a href="picom/picom.conf">Picom Configurations</a></li>
  </ol>
</details>
<img src="screenshots/dual_screen.png">

---

<img src="screenshots/main.png">


## How To Install

If you are using Fedora as your operating system, you can just run `install.sh`.

```bash
chmod +x ./install.sh
sudo ./install.sh
```
```
  Disclaimer: run --install with root privileges, --config
with normal user. Run install first with your arguments
Syntax: [-h/C/i [c|n]]

Options:
-h/--help            Prints this menu.
-i/--install         Starts installation. Requires sudo.
-C/--config          Configures system files.
-c/--common          Installs common programs.
-n/--nvidia          Installs Nvidia softwares.
```

It will then download all required files and replace config files with my configurations.

## Aditional Notes

Neovim requires following packages to run seamless.
```sh
 cd $HOME/.local/share/nvim/plugged/bracey.vim/
 npm install --prefix server
```
```sh
22:35:24 $ ~ →  npm list -g
/usr/local/lib
├── bash-language-server@2.0.0
├── coc-clangd@0.20.1
├── instant-markdown-d@0.2.0
├── live-server@1.2.2
├── neovim@4.10.1
├── npm-check-updates@12.4.0
├── npm@8.5.2
└── vls@0.7.6
```
<img src="screenshots/neovim.png">

## Credits

- **Wallpaper**: [Pexels Wallpaper Packs](https://www.pexels.com)

- **GTK**: [Qogir](https://www.gnome-look.org/p/1230631)

- **Icons**: [Kora](https://www.gnome-look.org/p/1256209/)

