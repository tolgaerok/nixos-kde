{ config, hostname, pkgs, username, lib, ... }:

{

  # Networking
  networking = {
    enableIPv6 = false;
    firewall.enable = false;
    firewall.allowPing = true;
    hostName = "NixOs";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
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

  # Adding a rule to the iptables firewall to allow NetBIOS name resolution traffic on UDP port 137 - NixOS wiki
  services.samba-wsdd.enable = true;

  # Adding a rule to the iptables firewall to allow NetBIOS name resolution traffic on UDP port 137
  networking.firewall.extraCommands =
    "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

  # mDNS
  #
  # This part may be optional for your needs, but I find it makes browsing in Dolphin easier,
  # and it makes connecting from a local Mac possible.
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
      enable = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };

  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add their password using sudo smbpasswd -a <user> as root
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb-NixOs23
      netbios name = smb-NixOs23
      security = user
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1 - COREPLUS)
      client min protocol = COREPLUS

      guest account = nobody
      map to guest = bad user
      load printers = yes
      printing = cups
      printcap name = cups
    '';

    shares = {
      # Home Directories Share - From my old fedora days
      homes = {
        comment = "Home Directories";
        browseable = false;
        "read only" = false;
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S";
        writable = true;
      };

      # Public Share
      NixOs23-KDE-Public = {
        path = "/home/tolga/Public";
        comment = "Public Share";
        browseable = true;
        "read only" = false;
        "guest ok" = true;
        writable = true;
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = "tolga";
        "force group" = "samba";
      };

      # Private Share
      NixOs23-KDE-Private = {
        path = "/home/NixOs-KDE";
        comment = "Private Share";
        browseable = true;
        "read only" = false;
        "guest ok" = false;
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };

      # Printer Share
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = true;
        browseable = true;
        "guest ok" = true;
        writable = false;
        printable = true;
        "create mask" = "0700";
      };
    };
  };

  # Add a systemd tmpfiles rule that creates a directory /var/spool/samba with permissions 1777 and ownership set to root:root.
  systemd.tmpfiles.rules = [ "d /var/spool/samba 1777 root root -" ];

}
