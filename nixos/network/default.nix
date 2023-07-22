{ config, hostname, pkgs, username, lib, ... }:

{

  imports = [
    # Configuration for networking and samba
    ./samba

  ];
  # Networking
  networking = {
    enableIPv6 = false;
    firewall.enable = false;
    firewall.allowPing = true;
    hostName = "NixOs";
    networkmanager.enable = true;
  };

  # Modify autoconnect priority of the connection
  systemd.services.modify-autoconnect-priority = {
    description = "Modify autoconnect priority of OPTUS_B27161 connection";
    script = ''
      nmcli connection modify OPTUS_B27161 connection.autoconnect-priority 1
    '';
  };

  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  # systemd.services.NetworkManager-wait-online.enable = false;

  # Enable openssh
  services = { openssh = { enable = true; }; };

  # Adding a rule to the iptables firewall to allow NetBIOS name resolution traffic on UDP port 137
  networking.firewall.extraCommands =
    "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

}
