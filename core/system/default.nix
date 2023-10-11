{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    # ./blocker
    # ./kernel-sysctl/SSD-28GB-default.nix       # kernel tweaks for laptop with SSD & 8GB RAM
    # ./kernel-sysctl/SSD-default.nix               # kernel tweaks for laptop (General)
    # ./theme    # GNOME THEME?
    #./boot-kernel
    ./bluetooth
    ./documentation
    ./env
    ./filesystem-support
    ./firewall
    ./fonts
    ./network

  ];

}
