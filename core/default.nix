{ ... }:

{
  #---------------------------------------------------------------------  
  # My CORE components        ( TODO LIST).
  #---------------------------------------------------------------------

  imports = [
    
    ./modules/iphone/iphone.nix
    ./nix
    ./packages
    ./programs
    ./services
    ./system

  ];

}
