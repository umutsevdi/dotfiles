# applets/

This directory contains my <a href="https://github.com/davatorium/rofi">Rofi</a> applets.

```sh
applets/
├── global.rasi
├── emoji
│   ├── config.rasi
│   └── launch.sh
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
Each Rofi applet get's it's color values from `global.rasi` file. So any change
  on colors affect rest of the applets. There is also an <a href="../bin/applet">Applet Launcher</a>.

- <a href="emoji/launch.sh">Emoji Picker</a> is a graphical application that copies
  selected emoji to the clipboard.
- <a href="launcher/launch.sh">Launcher</a> is a simple app launcher.
- <a href="powermenu/launch.sh">Powermenu</a> is user session program that allows
  user to logout, reboot or shutdown.
- <a href="music/launch.sh">Music Player</a> is menu that allows user to switch,
  stop or pause playing music.
