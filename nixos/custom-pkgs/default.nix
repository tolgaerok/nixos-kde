{ config, pkgs, ... }:

{

  imports = [

    #---------------------------------------------------------------------
    # Import custom in-house environment packages
    #---------------------------------------------------------------------

    ./mounter.nix
    ./unmounter.nix
    ./create-smb-user.nix
    ./make-executable.nix
    ./my-nix-commands.nix
    # ./rsync-home-to-server.nix    
    # ./trimmgenerations.nix
  ];

}
