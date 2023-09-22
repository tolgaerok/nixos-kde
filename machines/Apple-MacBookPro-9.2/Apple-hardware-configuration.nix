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
  boot.kernelParams = [ "mitigations=off" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a19fe475-fea4-4053-afa7-1608e18598a5";
    fsType = "ext4";
    # for ssd
    options =
      [ "noatime" "nodiratime" "discard" "errors=remount-ro" "data=ordered" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2B95-47BA";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b76b10a3-95ef-446b-9a6b-2e8836375403"; }];

  #  fileSystems."/mnt/nixos_share" = {
  #    device = "//192.168.0.20/LinuxData/HOME/PROFILES/NIXOS-23-05/TOLGA/";
  #    fsType = "cifs";
  #    options = let
  #      automountOpts =
  #        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";
  #      uid =
  #        "1000"; # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID
  #      gid =
  #        "100"; # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
  #      vers = "3.1.1";
  #      cacheOpts = "cache=loose";
  #      credentialsPath = "/etc/nixos/system/network/smb-secrets";
  #    in [
  #      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
  #    ];
  #  };

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

    #---------------------------------------------------------------------
  # NTFS Support
  #---------------------------------------------------------------------

  boot.supportedFilesystems = [ "ntfs" ];

  #---------------------------------------------------------------------
  # Enable memory compression for faster processing and less SSD usage
  #---------------------------------------------------------------------

  zramSwap.enable = true;
  zramSwap.memoryMax = 4294967296;
  zramSwap.memoryPercent = 20;

}
