{ config, hostname, pkgs, username, lib, ... }:

#--------------------------------------------------------------------- 
# Configuration for networking and samba
#--------------------------------------------------------------------- 

{

  imports = [

    ./samba

  ];

  #--------------------------------------------------------------------- 
  # Networking
  #--------------------------------------------------------------------- 

  networking = {
    enableIPv6 = false;
    firewall.enable = false;
    firewall.allowPing = true;
    hostName = "Tolga-NixOS";
    networkmanager.enable = true;
  };

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
  # Enable openssh
  #--------------------------------------------------------------------- 

  services = { openssh = { enable = true; }; };

  #--------------------------------------------------------------------- 
  # Adding a rule to the iptables firewall to allow NetBIOS name 
  # resolution traffic on UDP port 137
  #--------------------------------------------------------------------- 

  networking.firewall.extraCommands =
    "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

  #--------------------------------------------------------------------- 
  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  #--------------------------------------------------------------------- 

  networking.firewall.allowedTCPPorts = [ 22 445 139 80 443 22000 ];
  networking.firewall.allowedUDPPorts = [ 137 138 22000 21027 ];

}
