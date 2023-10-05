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
    ./kernel-sysctl/HHD-default.nix     # kernel tweaks for HHD with 4gb RAM
    # ./kernel-sysctl/SSD-default.nix   # kernel tweaks For SSD with x RAM
    ./network

  ];

}
