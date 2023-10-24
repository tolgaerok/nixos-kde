{ config, lib, ... }:

{

  #--------------------------------------------------------------------- 
  # Enable networking
  #---------------------------------------------------------------------
  networking.networkmanager.enable = true;

  #--------------------------------------------------------------------- 
  # Modify autoconnect priority of the connection
  #---------------------------------------------------------------------
  systemd.services.modify-autoconnect-priority = {
    description = "Modify autoconnect priority of OPTUS_B27161 connection";
    script = ''
      nmcli connection modify OPTUS_B27161 connection.autoconnect-priority 1
    '';
  };

  #--------------------------------------------------------------------- 
  # Prevent fragmentation and reassembly, which can improve network performance
  #---------------------------------------------------------------------
  networking.networkmanager.connectionConfig = {

    "ethernet.mtu" = 1462;
    "wifi.mtu" = 1462;

  };

}
