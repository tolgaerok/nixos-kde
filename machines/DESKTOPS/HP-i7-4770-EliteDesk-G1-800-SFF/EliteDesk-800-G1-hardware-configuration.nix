# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

#---------------------------------------------------------------------
# Imports and basic configuration
#---------------------------------------------------------------------
{ config, lib, pkgs, modulesPath, ... }:

with lib;

{
  #---------------------------------------------------------------------
  # Module imports
  #---------------------------------------------------------------------
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];  

  #---------------------------------------------------------------------
  # Boot configuration
  #---------------------------------------------------------------------
  boot = {
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
    # extraModulePackages = [ ];
    initrd.kernelModules = [ "nvidia" ];

    kernelModules = [
    "kvm-intel"
    "nvidia"
    "tcp_cubic"     # Cubic: A traditional and widely used congestion control algorithm
    "tcp_reno"      # Reno: Another widely used and stable algorithm
    "tcp_newreno"   # New Reno: An extension of the Reno algorithm with some improvements
    "tcp_bbr"       # BBR: Dynamically optimize how data is sent over a network, aiming for higher throughput and reduced latency
    "tcp_westwood"  # Westwood: Particularly effective in wireless networks
    ];

    # sysctl net.ipv4.tcp_available_congestion_control
    # sysctl net.ipv4.tcp_congestion_control
    # net.ipv4.tcp_available_congestion_control = reno cubic bbr westwood
    # westwood (Westwood: Aimed at improving performance over wireless networks)
    # sudo sysctl -w net.ipv4.tcp_congestion_control=westwood

    kernel.sysctl = {
      # "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_congestion_control" = "westwood";   # sets the TCP congestion control algorithm to Westwood for IPv4 in the Linux kernel.
    };

    kernelParams = [
      "mitigations=off"           # turns off certain CPU security mitigations. It might enhance performance
      "quiet"                     # suppresses most boot messages during the system startup
      "video.allow_duplicates=1"  # allows duplicate frames or similar, help smoothen video playback, especially on systems that struggle with rendering every single frame due to hardware limitations.

      # Isolating CPUs can potentially improve performance by dedicating them solely to the workload you want to optimize      
      # "isolcpus=1-7"                  # isolates CPUs 1 to 7 from the general system scheduler, often used for dedicated processing to prevent interference from unrelated tasks
      # "nohz_full=1-7"                 # isolates CPUs 1 to 7 from the tickless idle scheduler, which could potentially improve performance on those cores by reducing interruptions from timer ticks
      # "rcu_nocbs=1-7"                 # designates CPUs 1 to 7 for RCU (Read-Copy Update) processing, isolating them from other system tasks to enhance performance
      # "intel_pstate=disable"          # Disabling the Intel P-state driver, which manages the CPU frequency scaling in some Intel processors

    ];

    initrd.availableKernelModules = [
      "ahci"        # Enables the Advanced Host Controller Interface (AHCI) driver, typically used for SATA (Serial ATA) controllers.
      "ehci_pci"    # Enables the Enhanced Host Controller Interface (EHCI) driver for PCI-based USB controllers, providing support for USB 2.0.
      "nvme"
      "nvme"        # module in your initrd configuration can be useful if you plan to use an NVMe drive in the future
      "sd_mod"      # Enables the SCSI disk module (sd_mod), which allows the system to recognize and interact with SCSI-based storage devices.
      "sr_mod"      # Loads the SCSI (Small Computer System Interface) CD/DVD-ROM driver, allowing the system to recognize and use optical drives.
      "uas"         # Enables the USB Attached SCSI (UAS) driver, which provides a faster and more efficient way to access USB storage devices.
      "usb_storage" # Enables the USB Mass Storage driver, allowing the system to recognize and use USB storage devices like USB flash drives and external hard drives.
      "usbhid"      # Enables the USB Human Interface Device (HID) driver, which provides support for USB input devices such as keyboards and mice.
      "xhci_pci"    # Enables the eXtensible Host Controller Interface (xHCI) driver for PCI-based USB controllers, providing support for USB 3.0 and later standards.
    ];

    extraModulePackages = with config.boot.kernelPackages; [
    ];

  };

  #---------------------------------------------------------------------
  # File system configurations
  #---------------------------------------------------------------------
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/21882665-1b7e-422e-8dd8-607d8233f1a7";
    fsType = "ext4";

    # Optimize SSD
    # ---------------------------------------------
    options = [
      "data=ordered"      # Ensures data ordering, improving file system reliability and performance by writing data to disk in a specific order.
      "defaults"          # Applies the default options for mounting, which usually include common settings for permissions, ownership, and read/write access.
      "discard"           # Enables the TRIM command, which allows the file system to notify the storage device of unused blocks, improving performance and longevity of solid-state drives (SSDs).
      "errors=remount-ro" # Remounts the file system as read-only (ro) in case of errors to prevent further potential data corruption.
      "noatime"           # Disables updating access times for files, improving file system performance by reducing write operations.
      "nodiratime"        # Disables updating directory access time, improving file system performance by reducing unnecessary writes.
      "relatime"          # Updates the access time of files relative to the modification time, minimizing the performance impact compared to atime
    # "discard=async"     # Helps maintain the SSD's performance over time by reducing write amplification and improving block management

    ];

  };  
  
  #---------------------------------------------------------------------
  # Swap device configuration
  #---------------------------------------------------------------------
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
  # Host platform and hardware configurations
  #---------------------------------------------------------------------
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;

}
