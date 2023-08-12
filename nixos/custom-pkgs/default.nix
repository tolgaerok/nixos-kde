{ ... }: {

  imports = [

    #---------------------------------------------------------------------
    # Import custom in-house environment packages
    #---------------------------------------------------------------------

    ./create-smb-user.nix
    ./make-executable.nix
    ./mounter.nix
    ./my-nix-commands.nix
    ./unmounter.nix
    # ./rsync-home-to-server.nix    
    # ./trimmgenerations.nix
  ];

}
