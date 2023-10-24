{ ... }:

{
  #---------------------------------------------------------------------  
  # User-home-settings
  #---------------------------------------------------------------------

  imports = [
    
    ./create-user-home-directories.nix  # 1st
    ./create-user-profile-pics.nix      # 2nd

  ];

}
