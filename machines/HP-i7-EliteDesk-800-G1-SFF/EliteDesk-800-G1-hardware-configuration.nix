{ config, lib, pkgs, modulesPath, ... }:

# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

#--------------------------------------------------------------------- 
# Default Hardware Configuration for current pc
#--------------------------------------------------------------------- 

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    initrd.kernelModules = [ "nvidia" ];
    kernelModules = [ "kvm-intel" "nvidia" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "mitigations=off" ];
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
    initrd.availableKernelModules = [
      "ahci"
      "ehci_pci"
      "sd_mod"
      "sr_mod"
      "uas"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/21882665-1b7e-422e-8dd8-607d8233f1a7";
    fsType = "ext4";
    # for ssd
    options =
      [ "noatime" "nodiratime" "discard" "errors=remount-ro" "data=ordered" ];
  };

  fileSystems."/mnt/nixos_share" = {
    device = "//192.168.0.20/LinuxData/HOME/PROFILES/NIXOS-23-05/TOLGA/";
    fsType = "cifs";
    options = let
      automountOpts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";
      uid =
        "1000"; # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID
      gid =
        "100"; # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
      vers = "3.1.1";
      cacheOpts = "cache=loose";
      credentialsPath = "/etc/nixos/core/system/network/smb-secrets";
    in [
      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
    ];
  };

  swapDevices = [ ];

  #---------------------------------------------------------------------
  # For AMD hardware / chipsets
  #---------------------------------------------------------------------

  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # For Intel hardware / chipsets
  #---------------------------------------------------------------------

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # Tell Nix to use appropriate packages and configurations for this 
  # platform if they are not explicitly defined otherwise.
  #---------------------------------------------------------------------

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;

  #---------------------------------------------------------------------
  # Latest real-time (RT) version of the Linux kernel.
  #---------------------------------------------------------------------

  # kernelPackages = pkgs.linuxPackages-rt_latest;

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
