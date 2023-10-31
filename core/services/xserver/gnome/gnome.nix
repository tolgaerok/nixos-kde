{ config, pkgs, ... }: 

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.hide-universal-access
    papirus-icon-theme
    wmctrl
  ];
}

## NOTES
#
# gsettings set org.gnome.desktop.privacy remember-recent-files false
