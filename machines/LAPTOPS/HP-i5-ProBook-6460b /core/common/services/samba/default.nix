{ config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Adding a rule to the iptables firewall to allow NetBIOS name 
  # resolution traffic on UDP port 137 - NixOS wiki
  #---------------------------------------------------------------------

  services.samba-wsdd.enable = true;

  #---------------------------------------------------------------------
  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add 
  # their password using sudo smbpasswd -a <user> as root
  #---------------------------------------------------------------------

  services.samba = {
    enable = true;

    package = pkgs.samba4Full;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = HP_G800_NixOs_stoat
      # netbios name = smb-NixOs23
      security = user
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1++ = COREPLUS)
      client min protocol = COREPLUS

      # Store additional metadata or attributes associated with files or directories on the file system.
      ea support = yes

      # Serving files to Mac clients while maintaining compatibility with macOS-specific features and behaviors
      fruit:metadata = stream
      fruit:model = Macmini
      fruit:veto_appledouble = no
      fruit:posix_rename = yes
      fruit:zero_file_id = yes
      fruit:wipe_intentionally_left_blank_rfork = yes
      fruit:delete_empty_adfiles = yes

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

      Tolga_NixOS_Public = {
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

      #---------------------------------------------------------------------
      # Private Share
      #---------------------------------------------------------------------

      Tolga_NixOS_Private = {
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
