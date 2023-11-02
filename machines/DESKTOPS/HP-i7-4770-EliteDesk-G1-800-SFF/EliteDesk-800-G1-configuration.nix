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
#---------------------------------------------------------------------
# BLUE-TOOTH     REALTEK 5G
# CPU	           Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# GPU	           NVIDIA GeForce GT 1030/PCIe/SSE2
# MODEL          HP EliteDesk 800 G1 SFF
# MOTHERBOARD	   Intel® Q87
# NETWORK	       Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
# RAM	           28 GB DDR3
# SATA           SAMSUNG SSD 870 EVO 500GB
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
  networking.hostName = "HP-G800";                                            # Define your hostname. 
  
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
