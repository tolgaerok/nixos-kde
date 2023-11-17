{ config, pkgs, lib, ... }:

# customize and control the RGB lighting on your Intel motherboard and potentially other RGB-enabled hardware in your system. 
# This can be used for aesthetic purposes to create a visually appealing and personalized computer setup

{

  # OpenRGB and X Server Video Drivers Configuration
  services = {
    hardware.openrgb = {
      enable = true;
      motherboard = "intel";
      package = pkgs.openrgb-with-all-plugins;
    };

  };
}

