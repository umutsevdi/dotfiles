# .dotfiles

- This repository contains configuration settings and scripts that I've made or
used on my Operating System. These are the base dotfiles that I start with
when I set up a new environment.
- I'm using Fedora 35 on my personal computer. I use a fork of
<a href="https://github.com/i3/i3">i3 Window Manager</a> called <a href="https://github.com/Airblader/i3">i3-gaps</a>.

## Credits

- **Wallpaper**: [Pexels Wallpaper Packs](https://www.pexels.com)

- **GTK**: [Flat-Remix-GTK](https://www.gnome-look.org/p/1214931)

- **Icons**: [Kora Grey](https://www.gnome-look.org/p/1256209/)

- **Conky**: [Metro - Customized](https://www.deviantart.com/satya164/art/Conky-Metro-Clock-245432929)

<img src="screenshots/dual_screen.png">

<img src="screenshots/main.png">

<img src="screenshots/neovim.png">

---

## How To Install

### Pre Requirements

- <a href="https://github.com/kovidgoyal/kitty">Kitty</a>
- <a href="https://github.com/davatorium/rofi">Rofi</a>
- <a href="https://github.com/brndnmtthws/conky">Conky</a>
- <a href="https://github.com/altdesktop/playerctl">Playerctl</a>
- <a href="https://github.com/jordansissel/xdotool">xdotool</a>

### Using Installer

If you are using Fedora as your operating system, you can just run `install.sh`.

```bash
chmod +x ./install.sh
sudo ./install.sh
```

It will then download all required files and replace config files with my configurations.

## Polybar Configurations

- Polybar is an highly configurable text based menu bar that is commonly used with
tiled window managers. Check out <a href="https://github.com/polybar/polybar">Polybar</a>.
- I divided the bar configrations as config, bars and modules.


