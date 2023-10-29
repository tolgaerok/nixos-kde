mkdir ~/.themes
cp -R /run/current-system/sw/share/themes/Arc-Dark ~/.themes/
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=GTK_THEME=Arc-Dark 
