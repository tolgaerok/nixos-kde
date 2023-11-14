{ config, lib, pkgs, modulesPath, ... }:

#--------------------------------------------------------------------- 
# Default Hardware Configuration for current pc
#--------------------------------------------------------------------- 

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [

    "ahci"
    "applespi" # MacBook (Pro) SPI keyboard and touchpad driver
    "ehci_pci"
    "firewire_ohci"
    "intel_lpss_pci" # Intel Low Power Subsystem support in PCI mode
    "mac_hid" # HID support stuff for Macintosh computers.
    "sd_mod"
    "sdhci_pci"
    "spi_pxa2xx_pci" # PCI glue driver for SPI PXA2xx compatible controllers.
    "spi_pxa2xx_platform" # SPI keyboard / trackpad found on 12" MacBooks (2015 and later) and newer MacBook Pros (late 2016 and later).
    "sr_mod"
    "usb_storage"
    "usbcore"
    "usbhid"
    "xhci_pci"
  ];

  # systemd.services.fix-suspend = {
  #   script = ''
  #     # Fix macbook 12 suspend issues
  #     echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };

  # boot.extraModulePackages = [ ];

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];

  boot.kernelParams = [

    "intel_pstate=ondemand"
    "mitigations=off"
    "quiet"

  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a19fe475-fea4-4053-afa7-1608e18598a5";
    fsType = "ext4";

    # Optimize SSD
    options = [

      "data=ordered"
      "defaults"
      "discard"
      "errors=remount-ro"
      "nodiratime"
      "relatime"
      # "noatime"

    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2B95-47BA";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b76b10a3-95ef-446b-9a6b-2e8836375403"; }];

  #---------------------------------------------------------------------
  # For Intel hardware / chipsets
  #---------------------------------------------------------------------

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # Tell Nix to use appropriate packages and configurations for this 
  # platform if they are not explicitly defined otherwise.
  #---------------------------------------------------------------------

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
