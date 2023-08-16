{ ... }:

{
  #---------------------------------------------------------------------  
  # Import default.nix from folders below
  #---------------------------------------------------------------------

  imports = [
    #---------------------------------------------------------------------
    # Basic
    #---------------------------------------------------------------------

    ./archiver
    ./config-pkgs

    #---------------------------------------------------------------------
    # Multimedia
    #---------------------------------------------------------------------

    ./audio-video
    ./image
    ./multi-media

    #---------------------------------------------------------------------
    # Programming
    #---------------------------------------------------------------------

    ./devlopment

    #---------------------------------------------------------------------
    # Desktop
    #---------------------------------------------------------------------

    ./internet
    # ./iwd
    ./networking
    ./office

    #---------------------------------------------------------------------
    # System tools
    #---------------------------------------------------------------------

    ./misc
    ./tools
    ./utilities

    #---------------------------------------------------------------------
    # Enable flatpak
    #---------------------------------------------------------------------

    ./flatpak

  ];

}