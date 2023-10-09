{ config, hostname, pkgs, username, lib, ... }:

#--------------------------------------------------------------------- 
#   Configuration for networking and samba
#--------------------------------------------------------------------- 

{

  #--------------------------------------------------------------------- 
  #   Modify autoconnect priority of the connection for tolga's home
  #--------------------------------------------------------------------- 

  systemd.services.modify-autoconnect-priority = {
    description = "Modify autoconnect priority of OPTUS_B27161 connection";
    script = ''
      nmcli connection modify OPTUS_B27161 connection.autoconnect-priority 1
    '';
  };

  #--------------------------------------------------------------------- 
  #   Enable openssh
  #--------------------------------------------------------------------- 

  services = { openssh = { enable = true; }; };

}
