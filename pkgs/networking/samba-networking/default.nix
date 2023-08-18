{ pkgs, ... }: {

  # Samba and Networking:
  
  environment = {
    systemPackages = with pkgs; [

      # File Sharing & Network
      samba
      cifs-utils

    ];
  };
}
