{ config, pkgs, lib, ... }: {

  networking = {

    enableIPv6 = true;

    # What to display on other platform's network browsers
    hostName = "Tolga-NixOS";
    networkmanager.enable = true;

    # Configure firewall to your likings:
    firewall = {
      allowPing = true;

      # I want to configure my own ports
      enable = false;

      #--------------------------------------------------------------------- 
      # Curiously, `services.samba` does not automatically open
      # the needed ports in the firewall. Manualy open ports = [ 139 445 ]
      #--------------------------------------------------------------------- 

      allowedTCPPorts = [ 22 80 139 443 445 22000 ];
      allowedUDPPorts = [ 137 138 22000 21027 ];

      #--------------------------------------------------------------------- 
      # Adding a rule to the iptables firewall to allow NetBIOS name 
      # resolution traffic on UDP port 137
      #--------------------------------------------------------------------- 

      extraCommands =
        "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

    };
  };
}
