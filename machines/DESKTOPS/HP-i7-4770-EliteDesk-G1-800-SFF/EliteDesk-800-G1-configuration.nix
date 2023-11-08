{ username, config, pkgs, stdenv, lib, modulesPath, ... }:

# Tolga Erok
# 10/6/2023
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
#------------------ HP EliteDesk 800 G1 SFF ------------------------

# BLUE-TOOTH        REALTEK 5G
# CPU	              Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# i-GPU	            Integrated Intel HD Graphics
# d-GPU	            NVIDIA GeForce GT 1030/PCIe/SSE2
# MODEL             HP EliteDesk 800 G1 SFF
# MOTHERBOARD	      Intel® Q87 Express
# NETWORK	          Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
# RAM	              28 GB DDR3, 1600-MHz DDR3 SDRAM, Max 32
# STORAGE           SAMSUNG SSD 870 EVO 500GB
# EXPENSION SLOTS   (2) PCI Express x1 (v2.0), (1) PCI Express x 16 (v2.0 - wired as x4)
#                   (1) PCI Express x16 (v3.0), (1) Optional PCI (v2.3)
# PSU               320W
# CERTIFIED         RHEL, SUSE ENTERPRISE, WINDOWS 7 - 10 (Can run hacked W11 ent)
# SOURCE            https://support.hp.com/au-en/document/c03832938

#---------------------------------------------------------------------

{

  imports = [

    # Select your kernel
    #---------------------------------------------
    # ../../../core/system-tweaks/kernel-upgrades/latest-standard.nix         # Latest default NixOS kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                        # Zen kernel
    ../../../core/system-tweaks/kernel-upgrades/xanmod.nix                     # Xanmod kernel

    # Main core
    # ---------------------------------------------
    ../../../core
    ../../../core/boot/grub/grub.nix                                          # Use GRUB loader on this machine, not EFI
    ../../../core/gpu/nvidia/nvidia-stable-opengl                             # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./EliteDesk-800-G1-hardware-configuration.nix

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
  networking.hostName = "HP-G1-800";                                            # Define your hostname. 

  boot.kernel.sysctl = {
    "kernel.pid_max" = 4194304;                                # allows a large number of processes and threads to be managed
    "fs.aio-max-nr" = 1048576;
    "fs.inotify.max_user_watches" = 524288;
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
