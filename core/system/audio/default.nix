{ config, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE configuration 
# 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{

  # --------------------------------------------------------------------
  # Audio and extra audio packages
  #---------------------------------------------------------------------
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  sound.enable = true;

  services.pipewire = {
    
    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    wireplumber.enable = true;
  };

}
