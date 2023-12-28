{ config, pkgs, lib, inputs, ... }:
let
  # Tolga Erok
  # 30/10/2023
  # samba credentials:  Terminal run ==>   create-smb-user
  #---------------------------------------------------------------------

  # Change to suit
  mySharedPath = "/home/tolga/Public"; # Change this path to your desired value

  sharedOptions = {

    # Common options
    "guest ok" = true;
    "read only" = false;

    # Only users with samba in their extraGroup settings can access the following shared folders below HP800_Private && HP800_Public
    "valid users" = "@samba";

    browseable = true;
    writable = true;

  };

in {

  #---------------------------------------------------------------------
  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add 
  # their password using sudo smbpasswd -a <user> as root
  #---------------------------------------------------------------------
  services.samba-wsdd.enable = true;
  services.samba = {

    # 'sudo smbpasswd -a some_user'  # adds some_user to the samba login database
    # 'sudo smbpasswd -e some_user'  # enables some_user's samba login
    
    enable = true;

    package = pkgs.samba4Full;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      dns proxy = no
      name resolve order = lmhosts wins bcast host
      netbios name = ${config.networking.hostName}
      passdb backend = tdbsam
      security = user
      server role = standalone
      server string = Samba server (version: %v, protocol: %R)

      # Avoid ipv6 bind errors
      bind interfaces only = yes
      
      # hosts allow = 192.168.0. 127.0.0.1 localhost
      # hosts deny = 0.0.0.0/0
      hosts allow = 127.0.0. 10. 172.16.0.0/255.240.0.0 192.168. 169.254. fd00::/8 fe80::/10 localhost
      hosts deny = allow
      
      deadtime = 30
      guest account = nobody
      inherit permissions = yes
      map to guest = bad user
      pam password change = yes
      use sendfile = yes

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1++ = COREPLUS)      
      client min protocol = COREPLUS
      server min protocol = COREPLUS

      # Set AIO (Asynchronous I/O) read size to 0
      # 0 means that Samba should attempt to automatically determine the optimal read size based on the characteristics of the underlying filesystem.
      aio read size = 0

      # Set AIO write size to 0
      aio write size = 0

      # Enable VFS (Virtual File System) objects including ACL (Access Control List) xattr, Catia, and Streams xattr
      vfs objects = acl_xattr catia streams_xattr      
      vfs objects = catia streams_xattr
      
      # Set maximum IPC protocol to SMB3 for the client
      client ipc max protocol = SMB3

      # Set minimum IPC protocol to COREPLUS for the client
      client ipc min protocol = COREPLUS

      # Set maximum SMB protocol to SMB3 for the client
      client max protocol = SMB3

      # Set maximum SMB protocol to SMB3 for the server
      server max protocol = SMB3

      # this tells Samba to use a separate log file for each machine that connects
      log file = /var/log/samba/log.%m

      # Put a capping on the size of the log files (in Kb).
      max log size = 500

      # level 1=WARN, 2=NOTICE, 3=INFO, 4 and up = DEBUG
      # Ensure that users get to see auth and protocol negotiation info
      log level = 1 auth:3 smb:3 smb2:3

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
            
      # printing = cups
      printcap name = cups
      load printers = yes
      cups options = raw
      disable spoolss = yes
    '';

    shares = {
      sharedOptions = sharedOptions;

      #---------------------------------------------------------------------
      # Home Directories Share - From my old fedora days
      #---------------------------------------------------------------------

      homes = sharedOptions // {
        comment = "Home Directories";
        browseable = false;
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S, %D%w%S";
      };

      #---------------------------------------------------------------------
      # Public Share
      #---------------------------------------------------------------------

      HP800_Public = sharedOptions // {
        path = mySharedPath;
        comment = "Public Share";
        "create mask" = "0777";
        "directory mask" = "0777";

      };

      #---------------------------------------------------------------------
      # Private Share
      #---------------------------------------------------------------------

      HP800_Private = sharedOptions // {
        path = "/home/NixOs";
        comment = "Private Share";
        "create mask" = "0644";
        "directory mask" = "0755";
        "guest ok" = false;

      };

      #---------------------------------------------------------------------
      # Printer Share
      #---------------------------------------------------------------------

      printers = sharedOptions // {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = true;
        writable = false;
        printable = true;
        "create mask" = "0700";

      };
    };

  };

}
