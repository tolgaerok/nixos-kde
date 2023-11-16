{ ... }:

{

  #---------------------------------------------------------------------
  # System settings
  #---------------------------------------------------------------------

  imports = [

    ./appimage-registration   # Credits to Brian Francisco
    ./iphone/iphone.nix
    ./smart-drv-mon
    ./vm

  ];

}
