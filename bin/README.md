# bin/
This directory contains scripts that I wrote.

```
bin/
├── dotfetch
├── duppterm
├── kbswap
├── lockscreen
├── pickwp
├── polybar-daemon
└── pots
```
To execute any use

```sh
chmod +x $script_name
./$script_name
```
You can also link this directory to your `.bashrc` to be able to call them directly.
```sh
DF_PATH="$HOME/.dotfiles/bin"
PATH="$DF_PATH:$PATH"
```
