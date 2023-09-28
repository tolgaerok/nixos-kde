{ ... }:

{
  #---------------------------------------------------------------------  
  # My software packages        ( TODO LIST).
  #---------------------------------------------------------------------

  imports = [

    # ./plasma-manager/plasma-config.nix
    ./custom-pkgs
    ./flatpak
    ./internet
    ./packages.nix

  ];

}
