...
{

networking = {
    enableIPv6 = false;
    firewall.allowPing = true;
    hostName = "NixOs";
    networkmanager.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
  
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';

  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true; # Automatically open firewall ports
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb-NixOs23
      netbios name = smb-NixOs23
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
      load printers = yes
      printing = cups
      printcap name = cups
    '';
    shares = {      
      NixOs23-KDE-Public  = {
        path = "/home/tolga/Public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "writable" = "yes";
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = "tolga";
        "force group" = "samba";
      };
      NixOs23-KDE-Private = {
        path = "/home/NixOs-KDE";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = "yes";
        browseable = "yes";
        # to allow user 'guest account' to print.
        "guest ok" = "yes";
        writable = "no";
        printable = "yes";
        "create mode" = 0700;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];
}
