{ pkgs, ... }: 
{
  # File Management:
  environment = {
    systemPackages = with pkgs; [
      unzip
      usbutils
      xdg-desktop-portal-gtk
      xfce.thunar
      brasero
      gnome.simple-scan
      gum
      krusader
      blueberry

    ];
  };
}
