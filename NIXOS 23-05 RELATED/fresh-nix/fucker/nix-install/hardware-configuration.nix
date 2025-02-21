{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "uas"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "mitigations=off" ];
  # kernelPackages = pkgs.linuxPackages_latest;   # <====  Remove # to enable to update to the latest kernel automatically, use at own risk!

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e465813a-3a1a-4629-b2a4-d0ca24aaf10d";
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
      credentialsPath = "/etc/nixos/smb-secrets";
    in [
      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp3s0.useDHCP = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
