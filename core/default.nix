{ ... }:

{
  #---------------------------------------------------------------------  
  # My CORE components        ( TODO LIST).
  #---------------------------------------------------------------------

  imports = [
    
    ./modules/iphone/iphone.nix
    ./modules/smart-drv-mon
    ./nix
    ./packages
    ./programs
    ./services
    ./system

  ];

}
