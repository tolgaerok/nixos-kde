{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    # ./kernel-sysctl     # kernel tweaks
    #./boot-kernel
    ./bluetooth
    ./documentation
    ./env
    ./firewall
    ./fonts
    ./network

  ];

}
