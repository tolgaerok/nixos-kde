{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    #./boot-kernel
    ./bluetooth
    ./documentation
    ./env
    ./firewall
    ./fonts
    ./kernel-sysctl     # kernel tweaks
    ./network
    # ./theme    # GNOME THEME?
  ];

}
