{ config, lib, ... }:

{

  #--------------------------------------------------------------------- 
  # Modify autoconnect priority of the connection
  #---------------------------------------------------------------------
  systemd.services.modify-autoconnect-priority = {
    description = "Modify autoconnect priority of OPTUS_B27161 connection";
    script = ''
      nmcli connection modify OPTUS_B27161 connection.autoconnect-priority 1
    '';
  };

}
