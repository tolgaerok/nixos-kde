{ config, pkgs, lib, ... }:

{
  #---------------------------------------------------------------------
  # X11 and KDE Plasma
  #---------------------------------------------------------------------
  services.xserver = {
    enable = true;
    layout = "au";
    xkbVariant = "";

    # For Laptop
    libinput = {
      enable = true;
      touchpad.tapping = false;
      touchpad.naturalScrolling = true;
      touchpad.scrollMethod = "twofinger";
      touchpad.disableWhileTyping = true;
      touchpad.clickMethod = "clickfinger";
    };

    desktopManager = { plasma5.enable = true; };

    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;

        settings = {
          Theme = {
            CursorTheme = "breeze_cursors";
            iconTheme = "yaru-remix-theme";
          };
        };
        
        theme = "breeze";

      };
    };
  };
}
