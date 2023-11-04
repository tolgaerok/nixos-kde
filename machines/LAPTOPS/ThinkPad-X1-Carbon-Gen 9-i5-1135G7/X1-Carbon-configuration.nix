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
#------------------ ThinkPad X1 Carbon Gen 9 ------------------------

# MODEL             ThinkPad X1 Carbon Gen 9
# CPU               11th Gen Intel® Core™ i5-1135G7 (4C / 8T, 2.4 / 4.2GHz, 8MB)
# GPU               Intel Iris® Xe Graphics, DirectX® 12.1
# RAM               Up to 16GB Soldered LPDDR4x-4266
# SATA              Up to 1TB M.2 2280 SSD
# BLUE-TOOTH        Bluetooth® 5.1
# NETWORK           Intel Wi-Fi 6 AX201 (11ax, 2x2)
# CERTIFIED         Windows 11 Pro, Fedora, Linux, Ubuntu
# MOTHERBOARD       Intel SoC (System on Chip) platform
# SOURCE            [Lenovo ThinkPad X1 Carbon Gen 9]
#                   (https://www.lenovo.com/au/en/p/laptops/thinkpad/thinkpadx1/x1-carbon-g9/22tp2x1x1c9?orgRef=https%253A%252F%252Fwww.google.com%252F#tech_specs)

#---------------------------------------------------------------------


{

  imports = [

    # Select your kernel
    #---------------------------------------------
    # ../../../core/system-tweaks/kernel-upgrades/xanmod.nix                # Xanmod kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                      # Zen kernel
    ../../../core/system-tweaks/kernel-upgrades/latest-standard.nix         # Latest default NixOS kernel

    # Main core
    # ---------------------------------------------
    # ../../../core/gpu/nvidia/nvidia-stable-opengl                         # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    # ./EliteDesk-800-G1-hardware-configuration.nix
    ../../../core
    ../../../core/boot/efi/efi.nix                                          # Use GRUB loader on this machine, not EFI

    # Custom System tweaks
    # ---------------------------------------------
    # ../../../core/system-tweaks/zram/zram-28GB-SYSTEM.nix                   # Zram tweak for 28GB
    ../../../core/system-tweaks/kernel-tweaks/16GB-SYSTEM/16GB-SYSTEM.nix     # Kernel tweak for 28GB
    ../../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix              # SSD read & write tweaks

    # Users && user settings
    # ---------------------------------------------
    ../../../user/SOS/SOS.nix
    ../../../user/tolga/tolga.nix
    ../../../user/user-home-settings

  ];

  # Name of your pc to appear on the Network
  #---------------------------------------------------------------------
  networking.hostName = "X1-CARBON";                                            # Define your hostname. 
  
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
