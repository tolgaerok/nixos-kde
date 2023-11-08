{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    fluent-icon-theme
    gnome-extension-manager
    gnome.adwaita-icon-theme
    gnome.dconf-editor
    gnome.gnome-backgrounds
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-tweaks # Choose either gnome.gnome-tweaks or gnome3.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hide-universal-access
    papirus-icon-theme
    pkgs.gnome-user-docs
    pkgs.gnome-video-effects
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.google-earth-wallpaper
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.night-theme-switcher
    pkgs.gnomeExtensions.one-thing
    pkgs.gnomeExtensions.pano
    pkgs.gnomeExtensions.pip-on-top
    pkgs.gnomeExtensions.run-or-raise
    pkgs.gnomeExtensions.unblank
    wmctrl
    zafiro-icons
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
        # Additional extensions
        # "github.notifications@alexandre.dufournet.gmail.com"
        # "gsconnect@andyholmes.github.io"
        # "hue-lights@chlumskyvaclav.gmail.com"
        # "lightshell@dikasp.gitlab"
        # "mediacontrols@cliffniff.github.com"
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
