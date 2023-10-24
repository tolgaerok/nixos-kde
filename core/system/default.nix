{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    ./appimage-registration
    ./audio
    ./bluetooth
    ./documentation
    ./env
    ./filesystem-support
    ./firewall
    ./fonts
    ./network
    ./systemd
    ./unfree-insecure
    ./zram

  ];

}
