{
    
  # Import default.nix from folders below
  imports =
    [

      # Basic
      ./config-pkgs
      ./archiver

      # Multimedia
      ./audio-video
      ./image
      ./multi-media

      # Programming
      ./devlopment

      # Desktop
      ./internet
      ./networking
      ./office

      # System tools
      ./misc
      ./utilities

    ];  
  
}
