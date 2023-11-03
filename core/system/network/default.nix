{ config, lib, ... }:

{
  #--------------------------------------------------------------------- 
  # Enable networking
  #---------------------------------------------------------------------
  networking = {
    networkmanager = {
      enable = true;

      # Append Cloudflare and Google DNS servers
      appendNameservers = [ "1.1.1.1" "8.8.8.8" ];

      #--------------------------------------------------------------------- 
      # Prevent fragmentation and reassembly, which can improve network performance
      #---------------------------------------------------------------------
      connectionConfig = {
        "ethernet.mtu" = 1462;
        "wifi.mtu" = 1462;
      };

    };

    # terminal: arp -a
    extraHosts = ''
      192.168.0.1     router
      192.168.0.2     DIGA            # Smart TV
      192.168.0.6     iPhone          # Dads mobile
      192.168.0.7     Laser           # Laser Printer
      192.168.0.8     min21THIN       # EMMC thinClient
      192.168.0.10    TUNCAY-W11-ENT  # Dads PC
      192.168.0.11    ubuntu-server   # CasaOS
      192.168.0.13    HP-G800         # Main NixOS rig
      192.168.0.15    KingTolga       # My mobile
      192.168.0.20    W11-SERVER      # Main home server
    '';

  };

}

