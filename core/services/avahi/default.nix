{ config, pkgs, ... }:

{

  #---------------------------------------------------------------------
  #   Enable automatic discovery of the printer from other Linux systems with avahi running.
  #   mDNS - This part may be optional for your needs, but I find it makes 
  #   browsing in Dolphin easier, and it makes connecting from a 
  #   local Mac possible.
  #---------------------------------------------------------------------
  services.printing = {
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
  };

  # ---------------------------------------------------------------------
  #   Open avahi ports for sharing
  # ---------------------------------------------------------------------
  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];

  # ---------------------------------------------------------------------
  #   Configure avahi for sharing
  # ---------------------------------------------------------------------
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;

    publish = {
      addresses = true;
      domain = true;
      enable = true;
      hinfo = true;
      userServices = true;
      workstation = true;
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

}

