{ ... }:

{

  #---------------------------------------------------------------------
  # Various modules outside of nixos, custom additions
  #---------------------------------------------------------------------

  imports = [    
    ./appimage-registration   # Credits to Brian Francisco
    # ./apple-fonts
    ./custom-pkgs             # personal coded scriptBin's
    ./iphone/iphone.nix
    ./openRGB
    ./smart-drv-mon
    ./vm

  ];

}
