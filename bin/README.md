# bin/

Bu dizin yazdığım komut dosyalarını içerir.

```
bin/
├── applet
├── colorscheme
├── dotfetch
├── duppterm
├── kbswap
├── lockscreen
├── pickvideo
├── pickwp
└── pots
```

Herhangi bir kullanımı yürütmek için

```sh
chmod +x $script_name
./$script_name
```

Ayrıca bu dizini doğrudan arayabilmek için `.bashrc` dosyanıza bağlayabilirsiniz.

```sh
DF_PATH="$HOME/.dotfiles/bin"
PATH="$DF_PATH:$PATH"
```
