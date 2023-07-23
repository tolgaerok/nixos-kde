{pkgs, ...}: 
{
  # Samba and Networking:
  environment = {
    systemPackages = with pkgs; [
     samba
     cifs-utils
    ];
  };
}
