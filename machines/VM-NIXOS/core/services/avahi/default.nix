{ config, pkgs, ... }:

{

  #---------------------------------------------------------------------
  # mDNS - This part may be optional for your needs, but I find it makes 
  # browsing in Dolphin easier, and it makes connecting from a 
  # local Mac possible.
  #---------------------------------------------------------------------

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

