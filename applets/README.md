# applets/
This directory contains my <a href="https://github.com/davatorium/rofi">Rofi</a> applets. 
```sh
applets/
├── colors.rasi
├── launcher
│   ├── config.rasi
│   └── launcher.sh
├── music
│   ├── config.rasi
│   └── player.sh
└── powermenu
    ├── config.rasi
    └── powermenu.sh
```
- Each Rofi applet get's it's color values from `colors.rasi` file. So any change on colors affect rest of the applets.
- <a href="launcher/launcher.sh">Launcher</a> is a simple app launcher.
- <a href="powermenu/powermenu.sh">Powermenu</a> is user session program that allows user to logout, reboot or shutdown.
- <a href="music/player.sh">Music Player</a> is music player that allows user to switch, stop or pause playing music.