{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    # ./blocker
    # ./kernel-sysctl/SSD-default.nix   # kernel tweaks For SSD with x RAM
    # ./theme    # GNOME THEME?
    #./boot-kernel
    #./kernel-sysctl/HHD-default.nix     # kernel tweaks for HHD with 4gb RAM
    ./bluetooth
    ./documentation
    ./env
    ./firewall
    ./fonts
    ./network

  ]; 

}
