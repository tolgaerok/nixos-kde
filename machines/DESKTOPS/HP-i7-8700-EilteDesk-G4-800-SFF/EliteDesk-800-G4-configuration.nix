{ username, config, pkgs, stdenv, lib, modulesPath, ... }:

# Tolga Erok
# 3/11/2023
# My personal NIXOS KDE configuration 
# 
#              ¯\_(ツ)_/¯
#   ███▄    █     ██▓   ▒██   ██▒    ▒█████       ██████ 
#   ██ ▀█   █    ▓██▒   ▒▒ █ █ ▒░   ▒██▒  ██▒   ▒██    ▒ 
#  ▓██  ▀█ ██▒   ▒██▒   ░░  █   ░   ▒██░  ██▒   ░ ▓██▄   
#  ▓██▒  ▐▌██▒   ░██░    ░ █ █ ▒    ▒██   ██░     ▒   ██▒
#  ▒██░   ▓██░   ░██░   ▒██▒ ▒██▒   ░ ████▓▒░   ▒██████▒▒
#  ░ ▒░   ▒ ▒    ░▓     ▒▒ ░ ░▓ ░   ░ ▒░▒░▒░    ▒ ▒▓▒ ▒ ░
#  ░ ░░   ░ ▒░    ▒ ░   ░░   ░▒ ░     ░ ▒ ▒░    ░ ░▒  ░ ░
#     ░   ░ ░     ▒ ░    ░    ░     ░ ░ ░ ▒     ░  ░  ░  
#           ░     ░      ░    ░         ░ ░           ░  
#  
#------------------ HP EliteDesk 800 G4 SFF ------------------------

# BLUE-TOOTH        REALTEK 5G
# CPU	              Intel(R) Core(TM)  i7-8700 CPU @ 3.2GHz - 4.6Ghz (Turbo) x 6 (vPro)
# i-GPU	            Intel UHD Graphics 630, Coffee Lake 
# d-GPU             NVIDIA GeForce GT 1030/PCIe/SSE2
# MODEL             HP EliteDesk 800 G4 SFF
# MOTHERBOARD	      Intel Q370 PCH-H—vPro
# NETWORK	          Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
# RAM	              Maximum: 64 GB, DDR4-2666 (16 GB x 4)
# STORAGE           256 GB, M.2 2280, PCIe NVMe SSD
# EXPENSION SLOTS   (1) M.2 PCIe x1 2230 (for WLAN), (2) M.2 PCIe x4 2280/2230 combo (for storage)
#                   (2) PCI Express v3.0 x1, (1) PCI Express v3.0 x16 (wired as x4), (1) PCI Express v3.0 x16
# PSU               250W
# SOURCE            https://support.hp.com/au-en/document/c06047207

#---------------------------------------------------------------------

{

  imports = [

    # Select your kernel
    #---------------------------------------------
    # ../../../core/system-tweaks/kernel-upgrades/latest-standard.nix         # Latest default NixOS kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                        # Zen kernel
    ../../../core/system-tweaks/kernel-upgrades/xanmod.nix                    # Xanmod kernel

    # Main core
    # ---------------------------------------------
    ../../../core
    ../../../core/boot/efi/efi.nix                                            # Use GRUB loader on this machine, not EFI
    ../../../core/gpu/nvidia/nvidia-stable-opengl                             # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./EliteDesk-800-G4-hardware-configuration.nix

    # Custom System tweaks
    # ---------------------------------------------
    # ../../../core/system-tweaks/zram/zram-28GB-SYSTEM.nix                   # Zram tweak for 28GB
    ../../../core/system-tweaks/kernel-tweaks/28GB-SYSTEM/28GB-SYSTEM.nix     # Kernel tweak for 28GB
    ../../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix              # SSD read & write tweaks

    # Users && user settings
    # ---------------------------------------------
    ../../../user/SOS/SOS.nix
    ../../../user/tolga/tolga.nix
    ../../../user/user-home-settings

  ];

  # Name of your pc to appear on the Network
  #---------------------------------------------------------------------
  networking.hostName = "HP-G4-800";                                            # Define your hostname. 
  
  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # Accelerate package building (28GB+ system)
  nix.settings.max-jobs = 20;

  # Nobara Tweaks
  boot.kernel.sysctl = {
    "kernel.pid_max" = 4194304;                                # allows a large number of processes and threads to be managed
    "fs.aio-max-nr" = 1048576;                                 # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.
    "fs.inotify.max_user_watches" = 524288;                    # sets the maximum number of file system watches, enhancing file system monitoring capabilities.
  };
  
  
  #                                                                       
  #    .--~*teu.      .x~~"*Weu.              .n~~%x.       cuuu....uK    
  #   dF     988Nx   d8Nu.  9888c           x88X   888.     888888888     
  #  d888b   `8888>  88888  98888          X888X   8888L    8*888**"      
  #  ?8888>  98888F  "***"  9888%         X8888X   88888    >  .....      
  #   "**"  x88888~       ..@8*"          88888X   88888X   Lz"  ^888Nu   
  #        d8888*`     ````"8Weu          88888X   88888X   F     '8888k  
  #      z8**"`   :   ..    ?8888L        88888X   88888f   ..     88888> 
  #    :?.....  ..F :@88N   '8888N    .   48888X   88888   @888L   88888  
  #   <""888888888~ *8888~  '8888F  .@8c   ?888X   8888"  '8888F   8888F  
  #   8:  "888888*  '*8"`   9888%  '%888"   "88X   88*`    %8F"   d888"   
  #   ""    "**"`     `~===*%"`      ^*       ^"==="`       ^"===*%"`     
  #                                                                       
  #   https://patorjk.com/software/taag/#p=testall&h=1&c=bash&f=ANSI%20Shadow&t=23.05                                                                      
  # 
} 
