{ pkgs, ... }: {

  #---------------------------------------------------------------------
  # File Management:
  #---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # USB and Device Utilities
      usbutils

      # XDG and File Managers
      # xdg-desktop-portal-gtk
      # xfce.thunar

      # Other Miscellaneous Programs
      blueberry
      efibootmgr
      gum           # https://github.com/charmbracelet/gum
      krusader
    ];
  };
}
