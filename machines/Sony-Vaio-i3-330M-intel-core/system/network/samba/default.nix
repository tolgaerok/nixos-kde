{ config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Adding a rule to the iptables firewall to allow NetBIOS name 
  # resolution traffic on UDP port 137 - NixOS wiki
  #---------------------------------------------------------------------

  services.samba-wsdd.enable = true;
  networking.firewall.allowedTCPPorts = [ 5357 ]; # wsdd
  networking.firewall.allowedUDPPorts = [ 3702 ]; # wsdd

  #---------------------------------------------------------------------
  # mDNS - This part may be optional for your needs, but I find it makes 
  # browsing in Dolphin easier, and it makes connecting from a local Mac possible.
  #---------------------------------------------------------------------

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

  #---------------------------------------------------------------------
  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add 
  # their password using sudo smbpasswd -a <user> as root
  #---------------------------------------------------------------------

  services.samba = {
    enable = true;
    # package = pkgs.samba4Full;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = NixOs-Server
      # netbios name = NixOs-Server
      security = user
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1 - COREPLUS)
      client min protocol = COREPLUS

      guest account = nobody
      map to guest = bad user
            
      # printing = cups
      printcap name = cups
      load printers = yes
      cups options = raw
    '';

    shares = {

      #---------------------------------------------------------------------
      # Home Directories Share - From my old fedora days
      #---------------------------------------------------------------------

      homes = {
        comment = "Home Directories";
        browseable = false;
        "read only" = false;
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S, %D%w%S";
        writable = true;
      };

      #---------------------------------------------------------------------
      # Public Share
      #---------------------------------------------------------------------

      Sony-Public = {
        path = "/home/shaz/Public";
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

      #---------------------------------------------------------------------
      # Private Share
      #---------------------------------------------------------------------

      Sony-Private = {
        path = "/home/NixOs";
        comment = "Private Share";
        browseable = true;
        "read only" = false;
        "guest ok" = false;
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };

      #---------------------------------------------------------------------
      # Sony Nixos Share
      #---------------------------------------------------------------------

      Sony-Nixos-files = {
        path = "/etc/nixos/";
        comment = "Sony Configs";
        browseable = true;
        "read only" = false;
        "guest ok" = false;
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };

      #---------------------------------------------------------------------
      # Printer Share
      #---------------------------------------------------------------------

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

}
