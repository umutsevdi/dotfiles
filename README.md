# .dotfiles

<br />
<p align="center">
<a href="https://github.com/xtechnology/dotfiles">
<img src="https://img.icons8.com/fluency/344/fedora.png" alt="Logo" height="80">
</a>
<p align="center">
Bilgisayarımda kullandığım yapılandırma dosyaları.
<p align="center">
<img src="https://img.icons8.com/plasticine/344/bash.png" height=30 alt="Bash"><img src="https://github.com/i3/i3/raw /next/docs/logo-30.png" alt="i3 WM">
</p>

## Hakkında

Bu depo, cihazımda kullandığım tüm yapılandırma dosyalarını ve komut dosyalarını içerir. <a href="https://getfedora.org/en/server/download/">Fedora 36 Sunucu Sürümü</a> kullanıyorum. Bunlar başladığım temel nokta dosyaları
Yeni bir ortam kurduğumda.

Kişisel bilgisayarımda Fedora 36 kullanıyorum. ben çatal kullanıyorum
<a href="https://github.com/i3/i3">i3 Pencere Yöneticisi</a>, <a href="https://github.com/Airblader/i3">i3-gaps</a'yı aradı >.

<details open="open">
<summary>İçindekiler</summary>
<ol>
<li><a href="applets/">Uygulamalar</a></li>
<li><a href="bin/">Komut Dosyaları</a></li>
<li><a href="nvim/">Neovim</a></li>
<li><a href="polybar/">Polybar Yapılandırmaları</a></li>
<li><a href="i3/config">i3 Yapılandırmaları</a></li>
<li><a href="picom/picom.conf">Picom Yapılandırmaları</a></li>
</ol>
</details>
<img src="screenshots/dual_screen.png">

---

<img src="screenshots/main.png">

## Nasıl kurulur

İşletim sisteminiz olarak Fedora kullanıyorsanız, sadece `install.sh` komutunu çalıştırabilirsiniz.

```bash
chmod +x ./install.sh
sudo ./install.sh
```

```
Sorumluluk reddi: --install kök ayrıcalıklarıyla çalıştırın, --config
normal kullanıcı ile İlk önce argümanlarınızla kurulumu çalıştırın
Sözdizimi: [-h/C/i [c|n]]

Seçenekler:
-h/--help Bu menüyü yazdırır.
-i/--install Kurulumu başlatır. sudo gerektirir.
-C/--config Sistem dosyalarını yapılandırır.
-c/--ortak Ortak programları yükler.
-n/--nvidia Nvidia yazılımlarını yükler.
```

Ardından gerekli tüm dosyaları indirecek ve yapılandırma dosyalarını yapılandırmalarımla değiştirecek.

## Ek Notlar

Neovim'in sorunsuz çalışması için aşağıdaki paketler gerekir.

```ş
cd $HOME/.local/share/nvim/plugged/bracey.vim/
npm install --prefix server
```

```ş
22:35:24 $ ~ → npm list -g
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

## Kredi

- **Duvar Kağıdı**: [Pexels Duvar Kağıdı Paketleri](https://www.pexels.com)

- **GTK**: [Qogir](https://www.gnome-look.org/p/1230631)

- **Simgeler**: [Kora](https://www.gnome-look.org/p/1256209/)
