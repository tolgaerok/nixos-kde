{ ... }:

{
  #---------------------------------------------------------------------
  # Dynamic device management. udev is responsible for device detection, 
  # device node creation, and managing device events.
  #---------------------------------------------------------------------

  # services.udev.enable = true;

  services = {
    udev = {
      enable = true;

      # enable high precision timers if they exist
      # (https://gentoostudio.org/?page_id=420)

      extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
      '';

    };

  };
}
