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
    gnome.gnome-tweaks                        # Choose either gnome.gnome-tweaks or gnome3.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hide-universal-access
    papirus-icon-theme
    pkgs.gnome-user-docs
    pkgs.gnome-video-effects
    wmctrl
    zafiro-icons
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

}

## NOTES
#
# gsettings set org.gnome.desktop.privacy remember-recent-files false
