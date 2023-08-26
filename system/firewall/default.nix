{ config, pkgs, lib, ... }: {

  networking = {

    enableIPv6 = true;
    hostName = "Tolga-NixOS";
    networkmanager.enable = true;

    firewall = {
      allowPing = true;
      enable = false;

      #--------------------------------------------------------------------- 
      # Adding a rule to the iptables firewall to allow NetBIOS name 
      # resolution traffic on UDP port 137
      #--------------------------------------------------------------------- 

      extraCommands =
        "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

      #--------------------------------------------------------------------- 
      # Curiously, `services.samba` does not automatically open
      # the needed ports in the firewall.
      #--------------------------------------------------------------------- 

      allowedTCPPorts = [ 22 80 139 443 445 22000 ];
      allowedUDPPorts = [ 137 138 22000 21027 ];

    };
  };
}
