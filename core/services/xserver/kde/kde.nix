{ config, pkgs, ... }: 

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # scaling of fonts and graphical elements on the screen
  services.xserver.dpi = 98;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
}
