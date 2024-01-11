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

      # enable high precision timers if they exist && set I/O scheduler to NONE for ssd/nvme
      # autosuspend USB devices && autosuspend PCI devices
      # (https://gentoostudio.org/?page_id=420) 
      extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
        ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="ext4", ATTR{../queue/scheduler}="kyber"
        ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"cl
        ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"
      '';

    };

  };
}