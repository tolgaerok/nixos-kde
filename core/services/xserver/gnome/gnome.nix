{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "gnome";
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    fluent-icon-theme
    gnome-extension-manager
    gnome.adwaita-icon-theme
    gnome.gnome-backgrounds
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-tweaks # Choose either gnome.gnome-tweaks or gnome3.gnome-tweaks
    gnome.gnome.dconf-editor
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hide-universal-access
    papirus-icon-theme
    pkgs.gnome-user-docs
    pkgs.gnome-video-effects
    pkgs.gnome.dconf-editor
    pkgs.gnome.gnome-tweaks
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.google-earth-wallpaper
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.night-theme-switcher
    pkgs.gnomeExtensions.one-thing
    pkgs.gnomeExtensions.pano
    pkgs.gnomeExtensions.pip-on-top
    pkgs.gnomeExtensions.run-or-raise
    pkgs.gnomeExtensions.unblank
    pkgs.gnomeExtensions.vitals
    wmctrl

  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "GoogleEarthWallpaper@neffo.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "bluetooth-quick-connect@bjarosze.gmail.com"
        "caffeine@patapon.info"
        "ddterm@amezin.github.com"
        "just-perfection-desktop@just-perfection"
        "nightthemeswitcher@romainvigier.fr"
        "one-thing@github.com"
        "pano@elhan.io"
        "pip-on-top@rafostar.github.com"
        "run-or-raise@edvard.cz"
        "unblank@sun.wxg@gmail.com"
        # "github.notifications@alexandre.dufournet.gmail.com"
        # "gsconnect@andyholmes.github.io"
        # "hue-lights@chlumskyvaclav.gmail.com"
        # "lightshell@dikasp.gitlab"
        # "mediacontrols@cliffniff.github.com"
        # Additional extensions
      ];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      event-sounds = false;
    };

  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
