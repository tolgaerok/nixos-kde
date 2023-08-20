{ ... }: {

  imports = [

    #---------------------------------------------------------------------
    # Import custom in-house environment packages
    #---------------------------------------------------------------------

    # ./rsync-home-to-server.nix    
    # ./trimmgenerations.nix
    ./copy-back-up.nix
    ./create-smb-user.nix
    ./git_upload.nix
    ./make-executable.nix
    ./mounter.nix
    ./my-nix-commands.nix
    ./rsync-back-up.nix
    ./unmounter.nix
  ];

}
