{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    # ./blocker
    # ./theme    # GNOME THEME?
    #./boot-kernel
    ./bluetooth
    ./documentation
    ./env
    ./firewall
    ./fonts
    ./kernel-sysctl/SSD-8GB-RAM-default.nix       # kernel tweaks for laptop with SSD & 8GB RAM
  # ./kernel-sysctl/SSD-default.nix               # kernel tweaks for laptop (General)
    ./network

  ];

}
